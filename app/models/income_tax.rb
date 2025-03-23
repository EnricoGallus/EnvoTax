# frozen_string_literal: true

class IncomeTax < ApplicationRecord
  validates :tax_type, uniqueness: true
  validates :tax_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_type, :tax_rate, presence: true
end
