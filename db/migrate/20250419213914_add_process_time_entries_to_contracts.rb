# frozen_string_literal: true

# add flag to contracts to indicate if time entries should be processed
class AddProcessTimeEntriesToContracts < ActiveRecord::Migration[8.0]
  def change
    add_column :contracts, :process_time_entries, :boolean, default: false, null: false
  end
end
