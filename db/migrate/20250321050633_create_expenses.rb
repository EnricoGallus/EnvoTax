# frozen_string_literal: true

# migration for expense table
class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.references :client, null: true, foreign_key: true
      t.integer :amount_cents, default: 0, null: false
      t.string :amount_currency, default: "JPY", null: false
      t.text :description
      t.date :date, null: false

      t.timestamps
    end
  end
end
