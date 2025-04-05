# frozen_string_literal: true

# migration for adding invoice table
class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :status, null: false
      t.date :invoice_date, null: false

      t.timestamps
    end
  end
end
