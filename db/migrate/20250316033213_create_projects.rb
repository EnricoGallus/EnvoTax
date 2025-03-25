# frozen_string_literal: true

# Migration to add projects table
class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :client, null: false, foreign_key: true
      t.integer :hourly_rate_cents, default: 0, null: false
      t.string :hourly_rate_currency, default: "JPY", null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
