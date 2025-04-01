# frozen_string_literal: true

# the model used to save times worked on a project
class TimeEntry < ApplicationRecord
  belongs_to :project
  belongs_to :invoice, optional: true

  validates :name, presence: true
  validates :date, presence: true
  validates :time_from, presence: true
  validates :time_to, presence: true
  validate :no_time_overlap

  def spent_time_in_seconds
    time_to - time_from
  end

  def spent_time
    seconds = spent_time_in_seconds
    hours = seconds / 1.hour
    minutes = (seconds % 1.hour) / 1.minute

    format("%<hours>02d:%<minutes>02d", hours: hours, minutes: minutes)
  end

  def calculate_cost
    spent_time_in_seconds / 1.hour * project.client.hourly_rate
  end

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
end
