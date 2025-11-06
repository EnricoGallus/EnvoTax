# frozen_string_literal: true

# change country to int, rename zip to postal_code and adds prefecture and building
class UpdateAddressFields < ActiveRecord::Migration[8.0]
  def up
    rename_column :addresses, :zip, :postal_code
    add_column :addresses, :prefecture, :string
    add_column :addresses, :building, :string
  end

  def down
    rename_column :addresses, :postal_code, :zip
    remove_column :addresses, :prefecture, :string
    remove_column :addresses, :building, :string
  end
end
