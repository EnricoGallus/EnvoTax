# frozen_string_literal: true

# represents an invoice for a client
class Invoice < ApplicationRecord
  include Allocatable

  before_create :assign_invoice_number

  belongs_to :user
  belongs_to :contract_instance
  belongs_to :client

  monetize :total_amount_cents, with_currency: :jpy, numericality: { greater_than_or_equal_to: 0 }

  has_many :time_entries, dependent: :nullify
  has_many :expenses, dependent: :nullify

  validates :invoice_date, :start_date, :end_date, :status, presence: true
  validates :invoice_number, uniqueness: { scope: :client_id }, allow_nil: true

  enum :calculation_mode, { item_based: 0, total_based: 1 }
  enum :status, { draft: 0, approved: 1, partially_paid: 2, paid: 3, overdue: 4 }

  scope :unpaid, -> { where.not(status: :paid) }

  def details
    total_amount.format
  end

  def update_status_from_allocations!
    if allocated_amount >= total_amount
      update(status: :paid)
    elsif allocated_amount.positive?
      update(status: :partially_paid)
    elsif [:paid, :partially_paid].include?(status.to_sym)
      update(status: :approved)
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[contract_id end_date id invoice_date start_date status user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[contract expenses payment_allocations time_entries user]
  end

  private

  def assign_invoice_number
    return if invoice_number.present?

    period = invoice_date.year

    series = InvoiceSeries.find_or_create_by!(client_id: client.id, period: period)

    series.with_lock do
      self.sequence       = series.next_number
      self.invoice_number = "#{period}-#{sequence.to_s.rjust(4, '0')}"
      series.update!(next_number: sequence + 1)
    end
  end
end
