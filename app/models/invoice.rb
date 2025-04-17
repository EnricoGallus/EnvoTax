# frozen_string_literal: true

# represents an invoice for a client
class Invoice < ApplicationRecord
  include Allocatable

  before_create :generate_invoice_number

  belongs_to :user
  belongs_to :contract_instance

  monetize :total_amount_cents, with_currency: :jpy, numericality: { greater_than_or_equal_to: 0 }

  has_many :time_entries, dependent: :nullify
  has_many :expenses, dependent: :nullify

  validates :invoice_date, :start_date, :end_date, :status, presence: true
  validate :clear_generated_errors_for_job_save

  enum :calculation_mode, { item_based: 0, total_based: 1 }
  enum :status, { draft: 0, approved: 1, partially_paid: 2, paid: 3, overdue: 4 }

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

  def clear_generated_errors_for_job_save
    return unless validation_context == :job

    errors.delete(:contract_instance)
    errors.delete(:user)
    errors.delete(:status)
    errors.delete(:total_amount)
  end

  def generate_invoice_number
    return if invoice_number.present? || invoice_date.blank?

    year = invoice_date.year
    month = invoice_date.month

    latest_invoice = Invoice.where("strftime('%Y', invoice_date) = ?", year.to_s)
                            .order(invoice_number: :desc)
                            .limit(1)
                            .first
    sequence = 1
    if latest_invoice
      match = latest_invoice.invoice_number.match(/(\d{4})(\d{2})-(\d+)/)
      sequence = match[3].to_i + 1 if match
    end

    self.invoice_number = "#{year}#{month.to_s.rjust(2, '0')}-#{sequence.to_s.rjust(3, '0')}"
  end
end
