# frozen_string_literal: true

# create client table
class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.references :address, null: false, foreign_key: true
      t.integer :hourly_rate_cents, default: 0, null: false
      t.string :hourly_rate_currency, default: "JPY", null: false

      t.timestamps
    end
  end
end
