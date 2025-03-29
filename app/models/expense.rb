# frozen_string_literal: true

# represents an expense
class Expense < ApplicationRecord
  belongs_to :contract, optional: true
  belongs_to :invoice, optional: true
  belongs_to :cost_type

  has_one_attached :receipt

  monetize :amount_cents, with_currency: :jpy, numericality: { greater_than: 0 }

  validates :date, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount date description contract_id cost_type_id invoice_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[contract invoice cost_type]
  end
end
