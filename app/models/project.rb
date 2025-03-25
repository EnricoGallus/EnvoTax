# frozen_string_literal: true

# Project information. belongs to client, specifies hourly rate
class Project < ApplicationRecord
  belongs_to :client

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[client_id name]
  end
end
