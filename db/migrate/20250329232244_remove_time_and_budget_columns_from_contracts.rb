# frozen_string_literal: true

# This migration removes the start_date, end_date, and budget_limit columns from the contracts table.
class RemoveTimeAndBudgetColumnsFromContracts < ActiveRecord::Migration[8.0]
  def change
    remove_column :contracts, :start_date, :date
    remove_column :contracts, :end_date, :date
    remove_column :contracts, :budget_limit, :decimal
  end
end
