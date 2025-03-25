# frozen_string_literal: true

# category table used to create invoices for different categories
class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps

      t.index :name, unique: true
    end

    add_reference :invoices, :category, null: false, foreign_key: true
    add_reference :expenses, :category, null: false, foreign_key: true
  end
end
