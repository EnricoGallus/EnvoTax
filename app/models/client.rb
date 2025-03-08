# frozen_string_literal: true

# model for storing client information
class Client < ApplicationRecord
  belongs_to :address
  accepts_nested_attributes_for :address

  enum :currency, { yen: 0 }

  validates :name, presence: true
  validates :currency, presence: true, inclusion: { in: currencies.keys }
  validates :address, presence: true

  after_initialize :build_default_address, if: :new_record?

  private

  def build_default_address
    build_address unless address
  end
end
