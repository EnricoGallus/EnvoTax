# frozen_string_literal: true

# service that creates an invoice and attaches time entries and expenses to it
# depending on the selected time period
class InvoiceCreator
  def initialize(client, user, start_date, end_date, category_id)
    @client = client
    @user = user
    @start_date = start_date
    @end_date = end_date
    @category = Category.find(category_id)
  end

  def call
    ActiveRecord::Base.transaction do
      invoice = create_invoice

      assign_time_entries(invoice) if invoice.category.name == "Work"
      assign_expenses(invoice)
    end
  end

  private

  def create_invoice
    Invoice.create!(
      client: @client,
      user: @user,
      start_date: @start_date,
      end_date: @end_date,
      category: @category,
      invoice_date: Time.zone.now,
      status: :draft
    )
  end

  def assign_time_entries(invoice)
    time_entries = TimeEntry.where(project: @client.projects)
                            .where(date: @start_date..@end_date)
                            .where(invoice_id: nil)
    time_entries.update_all(invoice_id: invoice.id)
  end

  def assign_expenses(invoice)
    expenses = Expense.where(client: @client)
                      .where(category: @category)
                      .where(date: @start_date..@end_date)
                      .where(invoice_id: nil)
    expenses.update_all(invoice_id: invoice.id)
  end
end
