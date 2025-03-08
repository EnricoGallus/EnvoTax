# frozen_string_literal: true

# create client table
class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :currency
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
