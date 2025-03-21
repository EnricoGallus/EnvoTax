# frozen_string_literal: true

# represents an expense
class Expense < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :invoice, optional: true

  has_one_attached :receipt

  validates :amount, presence: true
  validates :category, presence: true
  validates :date, presence: true

  enum :category, { software: 0, hardware: 1, travel: 2, meals: 3, other: 4 }
end
