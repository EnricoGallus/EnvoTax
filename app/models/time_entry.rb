# frozen_string_literal: true

class TimeEntry < ApplicationRecord
  belongs_to :project

  validates :project_id, presence: true
  validates :name, presence: true
  validates :date, presence: true
  validates :time_from, presence: true
  validates :time_to, presence: true
end
