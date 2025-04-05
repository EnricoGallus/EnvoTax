# frozen_string_literal: true

# contract instance represents a period within a contract
class ContractInstance < ApplicationRecord
  belongs_to :contract
  has_many :expenses, dependent: :restrict_with_error
  has_many :invoices, dependent: :restrict_with_error

  monetize :budget_limit_cents, with_currency: :jpy, allow_nil: true, numericality: { greater_than: 0 }

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  delegate :name, to: :contract

  def self.ransackable_attributes(_auth_object = nil)
    %w[budget_limit contract_id end_date start_date]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["contract"]
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, "must be after the start date")
  end
end
