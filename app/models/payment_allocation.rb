# frozen_string_literal: true

# allocates payments to invoices or payment adjustments
class PaymentAllocation < ApplicationRecord
  belongs_to :income_tax
  belongs_to :payment_statement
  belongs_to :reference, polymorphic: true

  validates :amount, presence: true

  after_destroy :update_statuses
  after_save :update_statuses

  def update_statuses
    payment_statement.update_status!
    reference.update_status_from_allocations! if reference.present?
  end
end
