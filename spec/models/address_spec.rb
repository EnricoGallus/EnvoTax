# frozen_string_literal: true

require "rails_helper"

RSpec.describe Address, type: :model do
  subject(:address) { build(:address) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_presence_of(:prefecture) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:country) }

    it "validates format of postal_code" do
      expect(address).to allow_value("123-4567").for(:postal_code)
      expect(address).not_to allow_value("1234567").for(:postal_code).with_message("must be in the format XXX-XXXX")
    end

    it "raises an ArgumentError for an invalid country" do
      expect { address.country = 5 }.to raise_error(ArgumentError, "'5' is not a valid country")
    end

    it "validates inclusion of country", skip: "throws argument exception instead of failing validation" do
      expect(address).to validate_inclusion_of(:country).in_array(described_class.countries.keys)
    end
  end
end
