# frozen_string_literal: true

# represents an invoice to a client
class Invoice < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_many :time_entries, dependent: :nullify
  has_many :expenses, dependent: :nullify

  validates :invoice_date, :start_date, :end_date, :status, presence: true
  validate :clear_generated_errors_for_job_save

  enum :status, { draft: 0, sent: 1, paid: 2, overdue: 3 }

  def total_amount
    time_entries.sum(&:calculate_cost) + expenses.sum(&:amount)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[client_id created_at end_date id invoice_date start_date status updated_at user_id]
  end

  private

  def clear_generated_errors_for_job_save
    return unless validation_context == :job

    errors.delete(:client)
    errors.delete(:user)
    errors.delete(:status)
  end
end
