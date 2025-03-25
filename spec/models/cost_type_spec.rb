# frozen_string_literal: true

require "rails_helper"

RSpec.describe CostType, type: :model do
  describe "validations" do
    subject { build(:cost_type) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { is_expected.to have_many(:expenses) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:cost_type)).to be_valid
    end
  end

  describe "database constraints" do
    it "enforces name uniqueness at the database level" do
      cost_type = create(:cost_type)
      duplicate = build(:cost_type, name: cost_type.name)

      expect { duplicate.save!(validate: false) }
        .to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "enforces name presence at the database level" do
      cost_type = build(:cost_type, name: nil)

      expect { cost_type.save!(validate: false) }
        .to raise_error(ActiveRecord::NotNullViolation)
    end
  end

  describe ".ransackable_attributes" do
    it "returns allowed attributes for ransack" do
      expect(described_class.ransackable_attributes).to match_array(%w[id name])
    end
  end
end
