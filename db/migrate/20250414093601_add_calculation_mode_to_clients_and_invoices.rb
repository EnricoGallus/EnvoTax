# frozen_string_literal: true

# add calculation mode to clients and invoices
class AddCalculationModeToClientsAndInvoices < ActiveRecord::Migration[8.0]
  def change
    add_column :clients, :calculation_mode, :integer, default: 0, null: false
    add_column :invoices, :calculation_mode, :integer
  end
end
