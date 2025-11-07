# frozen_string_literal: true

# Backfills the invoice_series table from the invoices table.
class BackfillInvoiceSeriesFromInvoices < ActiveRecord::Migration[8.1]
  # Needed to add an index concurrently
  disable_ddl_transaction!

  def up
    # Backfill/merge series using an UPSERT
    execute <<~SQL.squish
      INSERT INTO invoice_series (client_id, period, next_number, created_at, updated_at)
      SELECT
        client_id,
        period,
        MAX(sequence) AS sequence,
        NOW(),
        NOW()
      FROM invoices
      WHERE client_id IS NOT NULL AND period IS NOT NULL
      GROUP BY client_id, period
      ON CONFLICT (client_id, period)
      DO UPDATE SET
        next_number   = GREATEST(invoice_series.next_number, EXCLUDED.next_number) + 1,
        updated_at = NOW();
    SQL
  end

  def down
    # no-op (data migration). If you really want to reverse,
    # you'd need to decide what "undo" means here.
  end
end
