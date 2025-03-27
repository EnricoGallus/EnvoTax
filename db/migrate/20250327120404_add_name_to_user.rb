# frozen_string_literal: true

# add name to user table
class AddNameToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string, null: false, default: ""

    add_index :users, :name, unique: true
  end
end
