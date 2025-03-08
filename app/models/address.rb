# frozen_string_literal: true

class Address < ApplicationRecord
  has_many :clients

  enum :country, { japan: 0 }

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :prefecture, :city, :street, presence: true
  validates :building, presence: false
  validates :country, presence: true, inclusion: { in: countries.keys }
end
