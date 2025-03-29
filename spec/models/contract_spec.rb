# frozen_string_literal: true

require "rails_helper"

RSpec.describe Contract, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to have_many(:expenses).dependent(:restrict_with_error) }
    it { is_expected.to have_many(:invoices).dependent(:restrict_with_error) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_presence_of(:status) }

    it { is_expected.to validate_numericality_of(:budget_limit_cents).is_greater_than_or_equal_to(0) }

    it "monetizes budget_limit" do
      contract = build(:contract, budget_limit_cents: 5000)
      expect(contract.budget_limit.cents).to eq(5000)
      expect(contract.budget_limit.currency.iso_code).to eq("JPY")
    end

    describe "custom validations" do
      context "end_date_after_start_date" do
        it "is valid when end_date is after start_date" do
          contract = build(:contract, start_date: Date.today, end_date: Date.tomorrow)
          expect(contract).to be_valid
        end

        it "is invalid when end_date is before start_date" do
          contract = build(:contract, start_date: Date.today, end_date: Date.yesterday)
          expect(contract).not_to be_valid
          expect(contract.errors[:end_date]).to include("must be after the start date")
        end

        it "is valid when end_date equals start_date" do
          contract = build(:contract, start_date: Date.today, end_date: Date.today)
          expect(contract).not_to be_valid
          expect(contract.errors[:end_date]).to include("must be after the start date")
        end
      end
    end
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1, completed: 2) }
  end

  describe "ransack" do
    it "allows searching on specific attributes" do
      expected_attrs = %w[budget_limit client_id end_date id name start_date status]
      expect(Contract.ransackable_attributes).to match_array(expected_attrs)
    end

    it "allows searching on specific associations" do
      expect(Contract.ransackable_associations).to contain_exactly("client")
    end
  end

  describe "monetized field" do
    let(:contract) { build(:contract, budget_limit_cents: 10_000) }

    it "converts cents to the money object" do
      expect(contract.budget_limit).to be_a(Money)
      expect(contract.budget_limit.cents).to eq(10_000)
    end

    it "uses JPY as the currency" do
      expect(contract.budget_limit.currency.iso_code).to eq("JPY")
    end
  end
end
