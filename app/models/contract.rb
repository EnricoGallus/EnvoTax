# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :client

  monetize :budget_limit_cents, with_currency: :jpy, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[budget_limit client_id end_date id name start_date status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["client"]
  end
end
