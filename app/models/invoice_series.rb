# frozen_string_literal: true

# represents the numbering series for invoices
class InvoiceSeries < ApplicationRecord
  belongs_to :client
end
