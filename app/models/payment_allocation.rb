# frozen_string_literal: true

# allocates payments to invoices or payment adjustments
class PaymentAllocation < ApplicationRecord
  belongs_to :income_tax
  belongs_to :payment_statement
  belongs_to :reference, polymorphic: true

  monetize :amount_cents, with_currency: :jpy, numericality: { greater_than: 0 }

  validate :amount_does_not_exceed_unallocated_amount

  after_destroy :update_statuses
  after_save :update_statuses

  def tax_amount
    (income_tax.tax_rate / 100) * amount
  end

  def net_amount
    amount - tax_amount
  end

  def update_statuses
    payment_statement.update_status!
    reference.presence&.update_status_from_allocations!
  end

  private

  def amount_does_not_exceed_unallocated_amount
    return unless amount > payment_statement.unallocated_amount

    errors.add(:amount, I18n.t("activerecord.errors.models.payment_allocation.attributes.amount.exceeded"))
  end
end
