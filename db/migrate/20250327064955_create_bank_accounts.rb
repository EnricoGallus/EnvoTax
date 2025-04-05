# frozen_string_literal: true

# This migration creates a bank_accounts table with various attributes
class CreateBankAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :bank_accounts do |t|
      t.string :account_holder
      t.string :bank_name
      t.string :branch_code
      t.string :account_number
      t.references :accountable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
