# frozen_string_literal: true

# the migration to add cost to time_entries
class AddCostToTimeEntries < ActiveRecord::Migration[8.0]
  def up
    change_table :time_entries, bulk: true do |t|
      t.monetize :cost, amount: { null: true, default: 0 }, currency: { null: true, default: "JPY" }
    end

    TimeEntry.find_each(&:save)

    change_table :time_entries, bulk: true do |t|
      t.change :cost_cents, :integer, null: false, default: 0
      t.change :cost_currency, :string, null: false, default: "JPY"
    end
  end

  def down
    remove_monetize :time_entries, :cost
  end
end
