# frozen_string_literal: true

# create table for payment allocation
class CreatePaymentAllocations < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_allocations do |t|
      t.integer :amount_cents, default: 0, null: false
      t.string :amount_currency, default: "JPY", null: false
      t.references :income_tax, null: false, foreign_key: true
      t.references :payment_statement, null: false, foreign_key: true
      t.references :reference, polymorphic: true, null: false

      t.timestamps
    end
  end
end
