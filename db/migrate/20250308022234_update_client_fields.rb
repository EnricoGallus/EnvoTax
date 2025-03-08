# frozen_string_literal: true

# update currency to int
class UpdateClientFields < ActiveRecord::Migration[8.0]
  def up
    change_column :clients, :currency, :integer
  end

  def down
    change_column :clients, :currency, :string
  end
end
