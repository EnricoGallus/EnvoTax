# frozen_string_literal: true

# service that creates an invoice and attaches time entries and expenses to it
# depending on the selected time period
class InvoiceCreator
  def initialize(contract, user, start_date, end_date, invoice_date)
    @contract = contract
    @user = user
    @start_date = start_date
    @end_date = end_date
    @invoice_date = invoice_date
  end

  def call
    Invoice.transaction do
      invoice = create_invoice

      assign_time_entries(invoice) if @contract.process_time_entries
      assign_expenses(invoice)

      invoice.total_amount = calculate_total(invoice)
      invoice.save!

      invoice
    end
  end

  private

  def create_invoice
    Invoice.create!(
      client: @contract.client,
      contract_instance: @contract.active_instance_by_period(@start_date, @end_date),
      user: @user,
      start_date: @start_date,
      end_date: @end_date,
      invoice_date: @invoice_date,
      status: :draft,
      period: @invoice_date.year,
      calculation_mode: @contract.client.calculation_mode
    )
  end

  def assign_time_entries(invoice)
    TimeEntry.where(project: @contract.client.projects)
             .where(date: @start_date..@end_date)
             .where(invoice_id: nil)
             .find_each { |entry| entry.update!(invoice: invoice) }
  end

  def assign_expenses(invoice)
    Expense.where(contract_instance: invoice.contract_instance)
           .where(date: @start_date..@end_date)
           .where(invoice_id: nil)
           .find_each { |expense| expense.update!(invoice: invoice) }
  end

  def calculate_total(invoice)
    InvoiceAmountCalculator.new(invoice).call
  end
end
