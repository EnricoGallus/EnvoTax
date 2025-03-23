# frozen_string_literal: true

require "rails_helper"

RSpec.describe CurrencyHelper, type: :helper do
  describe "#format_currency" do
    it "formats positive amounts correctly" do
      expect(helper.format_currency(1000)).to eq("1,000円")
    end

    it "formats zero correctly" do
      expect(helper.format_currency(0)).to eq("0円")
    end

    it "formats negative amounts correctly" do
      expect(helper.format_currency(-5000)).to eq("-5,000円")
    end

    it "formats decimal amounts with zero decimal places" do
      expect(helper.format_currency(1234.56)).to eq("1,235円")
    end

    it "formats large numbers with commas" do
      expect(helper.format_currency(1_000_000)).to eq("1,000,000円")
    end
  end
end
