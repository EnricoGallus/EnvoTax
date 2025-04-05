# frozen_string_literal: true

# model for cost type used by expenses and invoices
class CostType < ApplicationRecord
  has_many :expenses, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end
end
