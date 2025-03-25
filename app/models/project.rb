# frozen_string_literal: true

# Project information. belongs to client, specifies hourly rate
class Project < ApplicationRecord
  belongs_to :client

  monetize :hourly_rate_cents, with_currency: :jpy, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[client_id hourly_rate name]
  end
end
