# frozen_string_literal: true

# add a unique invoice number to the invoice
class AddInvoiceNumberToInvoice < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :invoice_number, :string, null: false, default: ""
    add_index :invoices, :invoice_number, unique: true
  end
end
