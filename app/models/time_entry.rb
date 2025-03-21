# frozen_string_literal: true

class TimeEntry < ApplicationRecord
  belongs_to :project
  belongs_to :invoice, optional: true

  validates :project_id, presence: true
  validates :name, presence: true
  validates :date, presence: true
  validates :time_from, presence: true
  validates :time_to, presence: true

  def calculate_cost
    hours = (time_to - time_from) / 1.hour
    hours * project.hourly_rate
  end
end
