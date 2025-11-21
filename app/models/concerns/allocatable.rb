# frozen_string_literal: true

# module to combine allocation relation. used by invoice and payment adjustments
module Allocatable
  extend ActiveSupport::Concern

  included do
    has_many :payment_allocations, as: :reference, dependent: :destroy

    scope :unpaid, -> { where.not(status: :paid) }
  end

  def allocated_amount
    payment_allocations.sum(:amount_cents).to_money
  end
end
