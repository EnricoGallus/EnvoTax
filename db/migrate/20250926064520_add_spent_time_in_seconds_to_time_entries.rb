# frozen_string_literal: true

# the migration to add spent_time_in_seconds to time_entries
class AddSpentTimeInSecondsToTimeEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :time_entries, :spent_time_in_seconds, :integer, default: 0, null: false
  end
end
