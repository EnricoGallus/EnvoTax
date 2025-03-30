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
    ActiveRecord::Base.transaction do
      invoice = create_invoice

      assign_time_entries(invoice)
      assign_expenses(invoice)
    end
  end

  private

  def create_invoice
    Invoice.create!(
      contract_instance: @contract.active_instance_by_period(@start_date, @end_date),
      user: @user,
      start_date: @start_date,
      end_date: @end_date,
      invoice_date: @invoice_date,
      status: :draft
    )
  end

  def assign_time_entries(invoice)
    time_entries = TimeEntry.where(project: @contract.client.projects)
                            .where(date: @start_date..@end_date)
                            .where(invoice_id: nil)
    time_entries.update_all(invoice_id: invoice.id)
  end

  def assign_expenses(invoice)
    expenses = Expense.where(contract_instance: invoice.contract_instance)
                      .where(date: @start_date..@end_date)
                      .where(invoice_id: nil)
    expenses.update_all(invoice_id: invoice.id)
  end
end
