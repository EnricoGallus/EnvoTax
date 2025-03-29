# frozen_string_literal: true

# removes the category table which is no longer used
class RemoveCategoryTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :categories
  end
end
