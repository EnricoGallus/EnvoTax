# frozen_string_literal: true

# Contract model representing a contract with a client
class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_many :contract_instances, dependent: :destroy

  enum :status, { active: 0, inactive: 1, completed: 2 }

  validates :name, :status, presence: true
  validate :only_one_process_time_entries_per_client

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

  private

  def only_one_process_time_entries_per_client
    return unless process_time_entries?

    return unless client.contracts.where(process_time_entries: true).where.not(id: id).exists?

    errors.add(:process_time_entries,
               I18n.t("activerecord.errors.models.contract.attributes.process_time_entries.unique"))
  end
end
