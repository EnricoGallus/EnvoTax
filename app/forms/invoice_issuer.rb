# frozen_string_literal: true

# dto for invoice issuer form
class InvoiceIssuer
  include ActiveModel::Model
  include ActiveModel::Attributes

  def self.model_name = ActiveModel::Name.new(self, nil, "Invoice")

  attribute :contract_id, :integer
  attribute :invoice_date, :date
  attribute :start_date, :date
  attribute :end_date, :date

  validates :invoice_date, :start_date, :end_date, presence: true

  def to_h
    {
      contract_id:,
      invoice_date:,
      start_date:,
      end_date:
    }
  end
end
