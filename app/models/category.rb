# frozen_string_literal: true

# category table used to create invoices for different categories
class Category < ApplicationRecord
  has_many :invoices, dependent: :restrict_with_error
  has_many :expenses, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
