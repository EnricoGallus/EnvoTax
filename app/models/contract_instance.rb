# frozen_string_literal: true

# contract instance represents a period within a contract
class ContractInstance < ApplicationRecord
  belongs_to :contract
  has_many :expenses, dependent: :restrict_with_error
  has_many :invoices, dependent: :restrict_with_error

  monetize :budget_limit_cents, with_currency: :jpy, allow_nil: true, numericality: { greater_than: 0 }

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  def name
    period = I18n.t(
      "contract_instance.period",
      start_date: I18n.l(start_date, format: :default),
      end_date: I18n.l(end_date, format: :default)
    )

    I18n.t(
      "contract_instance.name",
      client: contract.client.name,
      contract: contract.name,
      period: period
    )
  end

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
