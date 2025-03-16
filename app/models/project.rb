# frozen_string_literal: true

# Project information. belongs to client, specifies hourly rate
class Project < ApplicationRecord
  belongs_to :client

  validates :name, presence: true, uniqueness: true
  validates :hourly_rate, presence: true
  validates :hourly_rate, numericality: { greater_than_or_equal_to: 0 }
end
