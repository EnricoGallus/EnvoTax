# frozen_string_literal: true

require "rails_helper"

RSpec.describe IncomeTax, type: :model do
  describe "validations" do
    subject(:income_tax) { build(:income_tax) }

    it { is_expected.to validate_presence_of(:tax_type) }
    it { is_expected.to validate_presence_of(:tax_rate) }
    it { is_expected.to validate_uniqueness_of(:tax_type).ignoring_case_sensitivity }
    it { is_expected.to validate_numericality_of(:tax_rate).is_greater_than_or_equal_to(0) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:income_tax)).to be_valid
    end
  end

  describe "database constraints" do
    it "enforces tax_type uniqueness at the database level" do
      income_tax = create(:income_tax)
      duplicate = build(:income_tax, tax_type: income_tax.tax_type)

      expect { duplicate.save!(validate: false) }
        .to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "tax rate values" do
    it "allows zero tax rate" do
      income_tax = build(:income_tax, tax_rate: 0)
      expect(income_tax).to be_valid
    end

    it "rejects negative tax rate" do
      income_tax = build(:income_tax, tax_rate: -1)
      expect(income_tax).not_to be_valid
      expect(income_tax.errors[:tax_rate]).to include("must be greater than or equal to 0")
    end
  end
end
