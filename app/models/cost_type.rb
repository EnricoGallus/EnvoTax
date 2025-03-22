# frozen_string_literal: true

# model for cost type used by expenses and invoices
class CostType < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end
end
