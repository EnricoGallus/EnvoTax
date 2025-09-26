# frozen_string_literal: true

# the model used to save times worked on a project
class TimeEntry < ApplicationRecord
  belongs_to :project
  belongs_to :invoice, optional: true

  monetize :cost_cents, with_model_currency: :cost_currency, allow_nil: false

  validates :name, presence: true
  validates :date, presence: true
  validates :time_from, presence: true
  validates :time_to, presence: true
  validate :no_time_overlap

  before_validation :calculate_spent_time_and_cost

  def self.ransackable_attributes(_auth_object = nil)
    %w[date invoice_id name project_id time_from time_to]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[invoice project]
  end

  private

  def no_time_overlap
    return unless date.present? && time_from.present? && time_to.present?

    overlapping_exists = TimeEntry.where(date: date)
                                  .where.not(id: id)
                                  .exists?(["(time_from < ? AND time_to > ?) OR
                                      (time_from < ? AND time_to > ?) OR
                                      (time_from >= ? AND time_to <= ?)",
                                            time_to, time_from, time_from, time_from, time_from, time_to])

    return unless overlapping_exists

    errors.add(:base,
               I18n.t("activerecord.errors.models.time_entry.attributes.time_overlap.invalid"))
  end

  def calculate_cost
    hourly_rate = project&.client&.hourly_rate
    if hourly_rate.blank? || spent_time_in_seconds.blank?
      return Money.zero(hourly_rate&.currency || Money.default_currency)
    end

    Rational(spent_time_in_seconds) / 1.hour * hourly_rate
  end

  def calculate_spent_time_and_cost
    return unless time_from && time_to

    self.spent_time_in_seconds = time_to - time_from
    self.cost = calculate_cost
  end
end
