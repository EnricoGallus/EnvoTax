# frozen_string_literal: true

class ReplaceContractByInstanceInExpenseAndInvoice < ActiveRecord::Migration[8.0]
  def change
    add_reference :expenses, :contract_instance, foreign_key: true, index: true
    add_reference :invoices, :contract_instance, foreign_key: true, index: true

    remove_reference :expenses, :contract
    remove_reference :invoices, :contract
  end
end
