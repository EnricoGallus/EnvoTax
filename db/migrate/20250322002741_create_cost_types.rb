# frozen_string_literal: true

# creates the cost type table
class CreateCostTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :cost_types do |t|
      t.string :name, null: false

      t.timestamps

      t.index :name, unique: true
    end

    add_reference :expenses, :cost_type, null: false, foreign_key: true
  end
end
