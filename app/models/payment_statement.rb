# frozen_string_literal: true

# model to track payments made by clients
class PaymentStatement < ApplicationRecord
  include Allocatable

  belongs_to :client
  belongs_to :user

  has_one_attached :receipt

  has_many :payment_allocations, dependent: :destroy

  monetize :amount_cents, with_currency: :jpy, numericality: { greater_than_or_equal_to: 0 }

  enum :status, { pending: 0, partially_distributed: 1, distributed: 2 }

  validates :received_on, presence: true

  after_initialize :set_default_status, if: :new_record?

  def allocated_amount
    payment_allocations.sum(:amount_cents).to_money
  end

  def unallocated_amount
    amount - allocated_amount
  end

  def update_status!
    if payment_allocations.empty?
      update(status: :pending)
    elsif unallocated_amount <= 0
      update(status: :distributed)
    else
      update(status: :partially_distributed)
    end
  end

  private

  def set_default_status
    self.status ||= :pending
  end
end
