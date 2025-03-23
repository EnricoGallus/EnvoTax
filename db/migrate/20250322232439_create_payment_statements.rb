# frozen_string_literal: true

# payment statement table creation
class CreatePaymentStatements < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_statements do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.date :received_on, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
