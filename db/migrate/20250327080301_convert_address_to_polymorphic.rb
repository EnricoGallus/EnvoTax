# frozen_string_literal: true

# This migration converts the addresses table to a polymorphic association
class ConvertAddressToPolymorphic < ActiveRecord::Migration[8.0]
  def change
    add_column :addresses, :addressable_type, :string, null: false
    add_column :addresses, :addressable_id, :bigint, null: false
    add_index :addresses, [:addressable_type, :addressable_id]

    # If you need to remove the old client_id column
    remove_column :addresses, :client_id if column_exists?(:addresses, :client_id)
  end
end
