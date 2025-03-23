# frozen_string_literal: true

# migration for adding time entries
class CreateTimeEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :time_entries do |t|
      t.date :date
      t.time :time_from
      t.time :time_to
      t.string :name
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
