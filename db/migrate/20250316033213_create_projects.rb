# frozen_string_literal: true

# Migration to add projects table
class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :client, null: false, foreign_key: true
      t.decimal :hourly_rate, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
