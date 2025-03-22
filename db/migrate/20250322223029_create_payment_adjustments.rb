# frozen_string_literal: true

# model for payment adjustments like Bonus, Discount, Credits
class CreatePaymentAdjustments < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_adjustments do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.string :description
      t.date :date, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
