# frozen_string_literal: true

# Contract model representing a contract with a client
class Contract < ApplicationRecord
  belongs_to :client

  enum :status, { active: 0, inactive: 1, completed: 2 }

  has_many :expenses, dependent: :restrict_with_error
  has_many :invoices, dependent: :restrict_with_error

  monetize :budget_limit_cents, with_currency: :jpy, allow_nil: true, numericality: { greater_than: 0 }
  validates :name, :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  def self.ransackable_attributes(_auth_object = nil)
    %w[budget_limit client_id end_date id name start_date status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["client"]
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, "must be after the start date")
  end
end
