# frozen_string_literal: true

# creates invoice series table to track invoice numbers
class CreateInvoiceSeries < ActiveRecord::Migration[8.0]
  def change
    add_reference :invoices, :client, null: true, foreign_key: true

    create_table :invoice_series do |t|
      t.references :client, null: false, foreign_key: true
      t.integer :period, null: false
      t.integer :next_number, null: false, default: 1
      t.index [:client_id, :period], unique: true
      t.timestamps
    end

    change_table :invoices, bulk: true do |t|
      t.integer :period, null: false, default: ""
      t.integer :sequence, null: false, default: ""
    end

    Invoice.find_each do |invoice|
      period = invoice.invoice_date.year
      series = InvoiceSeries.find_or_create_by!(client: invoice.contract_instance.contract.client,
                                                period: period) do |series|
        series.next_number = 0
      end
      next_number = series.next_number + 1
      series.update!(next_number: next_number)

      invoice.update!(
        client: invoice.contract_instance.contract.client,
        period: period,
        sequence: next_number,
        invoice_number: "#{period}-#{next_number.to_s.rjust(4, '0')}"
      )
    end
    change_column_null :invoices, :client_id, false

    add_index :invoices, [:client_id, :period, :sequence], unique: true, name: "uniq_invoice_series_seq"
    add_index :invoices, [:client_id, :invoice_number], unique: true
    remove_index :invoices, :invoice_number
  end
end
