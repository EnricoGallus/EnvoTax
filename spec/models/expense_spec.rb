# frozen_string_literal: true

require "rails_helper"

RSpec.describe Expense, type: :model do
  subject(:expense) { build(:expense) }

  describe "associations" do
    it { is_expected.to belong_to(:invoice).optional }
    it { is_expected.to belong_to(:cost_type) }
    it { is_expected.to belong_to(:contract).optional }
    it { is_expected.to have_one_attached(:receipt) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:expense)).to be_valid
    end
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe ".ransackable_attributes" do
    it "returns allowed attributes for ransack" do
      expect(described_class.ransackable_attributes).to match_array(
        %w[amount date description cost_type_id]
      )
    end
  end

  describe ".ransackable_associations" do
    it "returns allowed associations for ransack" do
      expect(described_class.ransackable_associations).to match_array(
        %w[client invoice cost_type]
      )
    end
  end
end
