# frozen_string_literal: true

require "rails_helper"

RSpec.describe Expense, type: :model do
  subject(:expense) { build(:expense) }

  describe "associations" do
    it { is_expected.to belong_to(:invoice).optional }
    it { is_expected.to belong_to(:cost_type) }
    it { is_expected.to belong_to(:contract_instance).optional }
    it { is_expected.to have_one_attached(:receipt) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:expense)).to be_valid
    end
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe ".ransackable_attributes" do
    it "returns allowed attributes for ransack" do
      expect(described_class.ransackable_attributes).to match_array(
        %w[amount contract_instance_id cost_type_id date description invoice_id transaction_type]
      )
    end
  end

  describe ".ransackable_associations" do
    it "returns allowed associations for ransack" do
      expect(described_class.ransackable_associations).to match_array(
        %w[contract_instance invoice cost_type]
      )
    end
  end
end
