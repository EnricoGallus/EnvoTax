# frozen_string_literal: true

# Add total amount to invoice
class AddTotalAmountToInvoice < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :total_amount_cents, :integer, default: 0, null: false
    add_column :invoices, :total_amount_currency, :string, default: "JPY", null: false
  end
end
