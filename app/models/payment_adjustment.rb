# frozen_string_literal: true

# model for payment adjustments like bonuses, deductions, etc
class PaymentAdjustment < ApplicationRecord
  include Allocatable

  belongs_to :client
  belongs_to :user

  monetize :amount_cents, with_currency: :jpy, numericality: { greater_than: 0 }

  validates :date, presence: true

  enum :status, { pending: 0, partially_paid: 1, paid: 2, canceled: 3 }

  after_initialize :set_default_status, if: :new_record?

  scope :unpaid, -> { where.not(status: :paid) }

  def details
    amount.format
  end

  def update_status_from_allocations!
    if payment_allocations.empty?
      update(status: :pending)
    elsif amount - allocated_amount <= Money.new(0)
      update(status: :paid)
    else
      update(status: :partially_paid)
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount client_id date description id status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["client"]
  end

  private

  def set_default_status
    self.status ||= :pending
  end
end
