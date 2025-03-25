# frozen_string_literal: true

# create table for income tax
class CreateIncomeTaxes < ActiveRecord::Migration[8.0]
  def change
    create_table :income_taxes do |t|
      t.string :tax_type, null: false
      t.decimal :tax_rate, precision: 5, scale: 2, null: false

      t.timestamps

      t.index :tax_type, unique: true
    end
  end
end
