# frozen_string_literal: true

# model to track payments made by clients
class PaymentStatement < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_one_attached :receipt

  enum :status, { pending: 0, partially_distributed: 1, distributed: 2 }

  validates :amount, :received_on, presence: true

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :pending
  end
end
