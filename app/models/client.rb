# frozen_string_literal: true

# model for storing client information
class Client < ApplicationRecord
  belongs_to :address
  has_many :projects, dependent: :destroy
  accepts_nested_attributes_for :address

  monetize :hourly_rate_cents, with_currency: :jpy, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true

  after_initialize :build_default_address, if: :new_record?

  def self.ransackable_attributes(_auth_object = nil)
    %w[name address hourly_rate]
  end

  private

  def build_default_address
    build_address unless address
  end
end
