# frozen_string_literal: true

require "rails_helper"

RSpec.describe Contract, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to have_many(:contract_instances).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:status) }

    context "when validating process_time_entries" do
      let(:client) { create(:client) }

      context "when process_time_entries is true" do
        it "is valid if no other contract for the client has process_time_entries set to true" do
          create(:contract, client: client, process_time_entries: false)
          contract = build(:contract, client: client, process_time_entries: true)

          expect(contract).to be_valid
        end

        it "is invalid if another contract for the client already has process_time_entries set to true" do
          create(:contract, client: client, process_time_entries: true)
          contract = build(:contract, client: client, process_time_entries: true)

          expect(contract).not_to be_valid
          expect(contract.errors[:process_time_entries]).to include(
            I18n.t("activerecord.errors.models.contract.attributes.process_time_entries.unique")
          )
        end
      end

      context "when process_time_entries is false" do
        it "is valid regardless of other contracts' process_time_entries values" do
          create(:contract, client: client, process_time_entries: true)
          contract = build(:contract, client: client, process_time_entries: false)

          expect(contract).to be_valid
        end
      end
    end
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1, completed: 2) }
  end

  describe "ransack" do
    it "allows searching on specific attributes" do
      expected_attrs = %w[client_id id name status]
      expect(described_class.ransackable_attributes).to match_array(expected_attrs)
    end

    it "allows searching on specific associations" do
      expect(described_class.ransackable_associations).to contain_exactly("client")
    end
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:contract)).to be_valid
    end
  end
end
