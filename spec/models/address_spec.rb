# frozen_string_literal: true

require "rails_helper"

RSpec.describe Address, type: :model do
  subject(:address) { build(:address, :for_user) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_presence_of(:prefecture) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:country) }

    it { is_expected.to define_enum_for(:country).with_values(japan: 0) }

    it "validates format of postal_code for valid entry" do
      address.postal_code = "123-4567"
      expect(address).to be_valid
    end

    it "validates format of postal_code for invalid entry" do
      address.postal_code = "1234567"
      expect(address).not_to be_valid
      expect(address.errors[:postal_code]).to include(
        I18n.t("activerecord.errors.models.address.attributes.postal_code.invalid")
      )
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:addressable) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:address, :for_user)).to be_valid
    end
  end

  describe "country enum" do
    it "allows setting valid country" do
      address.country = "japan"
      expect(address).to be_valid
    end

    it "raises an ArgumentError for an invalid country" do
      expect { address.country = "invalid_country" }.to raise_error(ArgumentError)
    end
  end
end
