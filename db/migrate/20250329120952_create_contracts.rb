# frozen_string_literal: true

class CreateContracts < ActiveRecord::Migration[8.0]
  def change
    create_table :contracts do |t|
      t.string :name, null: false
      t.references :client, null: false, foreign_key: true
      t.integer :budget_limit_cents
      t.string :budget_limit_currency, default: "JPY"
      t.date :start_date, null: false
      t.date :end_date
      t.integer :status, null: false, default: 0

      t.timestamps

      t.index :name, unique: true
    end
  end
end
