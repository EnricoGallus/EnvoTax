# frozen_string_literal: true

# represents an expense
class Expense < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :invoice, optional: true
  belongs_to :cost_type
  belongs_to :category

  has_one_attached :receipt

  validates :amount, presence: true
  validates :date, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount date description cost_type_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[client invoice cost_type]
  end
end
