# frozen_string_literal: true

# Project information. belongs to client, specifies hourly rate
class Project < ApplicationRecord
  belongs_to :client

  validates :name, presence: true, uniqueness: true
  validates :hourly_rate, presence: true
  validates :hourly_rate, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[client_id hourly_rate name]
  end
end
