# frozen_string_literal: true

# adds account_type to bank_accounts
class AddAccountTypeToBankAccount < ActiveRecord::Migration[8.0]
  def change
    add_column :bank_accounts, :account_type, :integer, default: 0, null: false
  end
end
