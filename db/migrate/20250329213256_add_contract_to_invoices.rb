# frozen_string_literal: true

# replaces client_id and category_id with contract_id for invoices
#
# This migration is part of the transition to using contracts instead of clients and categories for invoices and expenses.
# It removes the client_id and category_id columns from the expenses table and adds a contract_id column.
# The contract_id column is a foreign key reference to the contracts table.
class AddContractToInvoices < ActiveRecord::Migration[8.0]
  def change
    add_reference :invoices, :contract, foreign_key: true, null: false
    remove_column :invoices, :client_id
    remove_column :invoices, :category_id
  end
end
