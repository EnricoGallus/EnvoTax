# frozen_string_literal: true

# add transaction_type to expenses table
class AddTransactionTypeToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :transaction_type, :integer, default: 0, null: false
  end
end
