# frozen_string_literal: true

# Contract model representing a contract with a client
class Contract < ApplicationRecord
  belongs_to :client

  has_many :contract_instances, dependent: :destroy
  has_many :expenses, dependent: :restrict_with_error
  has_many :invoices, dependent: :restrict_with_error

  enum :status, { active: 0, inactive: 1, completed: 2 }

  validates :name, presence: true

  def active_instance_by_period(start_date, end_date)
    contract_instances.where("start_date <= ? AND end_date >= ?",
                             start_date, end_date).first
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[client_id id name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["client"]
  end
end
