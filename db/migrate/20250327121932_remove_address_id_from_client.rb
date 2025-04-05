# frozen_string_literal: true

# remove address id after
class RemoveAddressIdFromClient < ActiveRecord::Migration[8.0]
  def change
    remove_column :clients, :address_id
  end
end
