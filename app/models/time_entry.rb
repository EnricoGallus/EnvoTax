# frozen_string_literal: true

# the model used to save times worked on a project
class TimeEntry < ApplicationRecord
  belongs_to :project
  belongs_to :invoice, optional: true

  validates :name, presence: true
  validates :date, presence: true
  validates :time_from, presence: true
  validates :time_to, presence: true

  def calculate_cost
    hours = (time_to - time_from) / 1.hour
    hours * project.hourly_rate
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[date invoice_id name project_id time_from time_to]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[invoice project]
  end
end
