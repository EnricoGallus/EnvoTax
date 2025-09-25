# frozen_string_literal: true

# model for storing client information
class Client < ApplicationRecord
  include AddressableConcern

  belongs_to :user

  has_many :projects, dependent: :destroy
  has_many :contracts, dependent: :destroy

  enum :calculation_mode, { item_based: 0, total_based: 1 }

  monetize :hourly_rate_cents, with_currency: :jpy, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name address hourly_rate]
  end
end
