# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  describe "validations" do
    subject { build(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { is_expected.to have_many(:invoices) }
    it { is_expected.to have_many(:expenses) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:category)).to be_valid
    end
  end

  describe "database constraints" do
    it "enforces name uniqueness at the database level" do
      category = create(:category)
      duplicate = build(:category, name: category.name)

      expect { duplicate.save!(validate: false) }
        .to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "enforces name presence at the database level" do
      category = build(:category, name: nil)

      expect { category.save!(validate: false) }
        .to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
