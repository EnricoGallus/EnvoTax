# frozen_string_literal: true

# This migration creates the contract_instances table with references to the contracts table.
class CreateContractInstances < ActiveRecord::Migration[8.0]
  def change
    create_table :contract_instances do |t|
      t.references :contract, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :budget_limit_cents
      t.string :budget_limit_currency

      t.timestamps
    end
  end
end
