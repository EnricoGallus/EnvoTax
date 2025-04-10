# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContractInstance, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:contract) }
    it { is_expected.to have_many(:expenses).dependent(:restrict_with_error) }
    it { is_expected.to have_many(:invoices).dependent(:restrict_with_error) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_numericality_of(:budget_limit_cents).allow_nil }

    describe "custom validations" do
      context "when validating end_date after start_date" do
        it "is valid when end_date is after start_date" do
          instance = build(:contract_instance, start_date: Time.zone.today, end_date: Time.zone.tomorrow)
          expect(instance).to be_valid
        end

        it "is invalid when end_date is before start_date" do
          instance = build(:contract_instance, start_date: Time.zone.today, end_date: Time.zone.yesterday)
          expect(instance).not_to be_valid
          expect(instance.errors[:end_date]).to include("must be after the start date")
        end

        it "is valid when end_date equals start_date" do
          instance = build(:contract_instance, start_date: Time.zone.today, end_date: Time.zone.today)
          expect(instance).to be_valid
        end
      end
    end
  end

  describe "monetize" do
    subject(:model) { build(:contract_instance) }

    it "requires values greater than 0 when present" do
      model.budget_limit = Money.new(0, "JPY")
      model.valid?
      expect(model.errors[:budget_limit]).to include("must be greater than 0")

      model.budget_limit = Money.new(100, "JPY")
      model.valid?
      expect(model.errors[:budget_limit]).to be_empty
    end
  end

  describe "#name" do
    it "formats name with client and period information" do
      client = create(:client, name: "ACME Corp")
      contract = create(:contract, name: "Test Contract", client: client)
      instance = build(:contract_instance,
                       contract: contract,
                       start_date: Date.new(2023, 1, 1),
                       end_date: Date.new(2023, 12, 31))

      expect(instance.name).to eq("ACME Corp: Test Contract (2023-01-01 to 2023-12-31)")
    end
  end

  describe "ransack" do
    it "allows searching on specific attributes" do
      expected_attrs = %w[budget_limit contract_id end_date start_date]
      expect(described_class.ransackable_attributes).to match_array(expected_attrs)
    end

    it "allows searching on specific associations" do
      expect(described_class.ransackable_associations).to contain_exactly("contract")
    end
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:contract_instance)).to be_valid
    end
  end
end
