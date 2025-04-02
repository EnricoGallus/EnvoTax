# frozen_string_literal: true

require "rails_helper"

RSpec.describe Client, type: :model do
  subject(:client) { build(:client) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:hourly_rate).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { is_expected.to have_many(:projects).dependent(:destroy) }
    it { is_expected.to have_one(:address).dependent(:destroy) }
  end

  describe "addressable concern" do
    it { is_expected.to accept_nested_attributes_for(:address).allow_destroy(true) }

    it "can build an address" do
      address_attributes = {
        postal_code: "123-4567",
        prefecture: "Tokyo",
        city: "Shibuya",
        street: "Example Street",
        country: "japan"
      }

      client.build_address(address_attributes)
      expect(client.address).to be_a(Address)
      expect(client.address.postal_code).to eq("123-4567")
      expect(client.address.prefecture).to eq("Tokyo")
      expect(client.address.city).to eq("Shibuya")
      expect(client.address.street).to eq("Example Street")
      expect(client.address.country).to eq("japan")
    end

    it "creates an address when saving with nested attributes" do
      client_with_address = build(:client, address_attributes: {
                                    postal_code: "123-4567",
                                    prefecture: "Tokyo",
                                    city: "Shibuya",
                                    street: "Example Street",
                                    country: "japan"
                                  })

      expect { client_with_address.save }.to change(Address, :count).by(1)
      expect(client_with_address.address).to be_persisted
    end
  end

  describe ".ransackable_attributes" do
    it "returns the allowed attributes for searching" do
      expect(Client.ransackable_attributes).to match_array(%w[name address hourly_rate])
    end
  end
end
