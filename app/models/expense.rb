# frozen_string_literal: true

# represents an expense
class Expense < ApplicationRecord
  belongs_to :contract_instance, optional: true
  belongs_to :invoice, optional: true
  belongs_to :cost_type

  has_one_attached :receipt

  monetize :amount_cents, with_currency: :jpy, numericality: { greater_than: 0 }

  enum :transaction_type, { debit: 0, credit: 1 }

  validates :date, presence: true
  validates :transaction_type, inclusion: { in: transaction_types.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount date description contract_instance_id cost_type_id invoice_id transaction_type]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[contract_instance invoice cost_type]
  end
end
