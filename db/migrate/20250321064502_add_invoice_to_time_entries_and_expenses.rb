# frozen_string_literal: true

class AddInvoiceToTimeEntriesAndExpenses < ActiveRecord::Migration[8.0]
  def change
    add_reference :time_entries, :invoice, foreign_key: true
    add_reference :expenses, :invoice, foreign_key: true
  end
end
