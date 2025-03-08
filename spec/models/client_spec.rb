# frozen_string_literal: true

require "rails_helper"

RSpec.describe Client, type: :model do
  subject(:client) { build(:client) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }

    it "raises an ArgumentError for an invalid currency" do
      expect { client.currency = 5 }.to raise_error(ArgumentError, "'5' is not a valid currency")
    end

    it "validates inclusion of currency", skip: "throws argument exception instead of failing validation" do
      expect(client).to validate_inclusion_of(:currency).in_array(described_class.currencies.keys)
    end
  end
end
