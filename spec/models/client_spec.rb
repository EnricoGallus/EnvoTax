# frozen_string_literal: true

require "rails_helper"

RSpec.describe Client, type: :model do
  subject(:client) { build(:client) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:hourly_rate).is_greater_than_or_equal_to(0) }
  end
end
