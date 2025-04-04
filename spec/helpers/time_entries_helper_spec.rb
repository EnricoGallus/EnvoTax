# frozen_string_literal: true

require "rails_helper"

RSpec.describe TimeEntriesHelper, type: :helper do
  describe "#format_spent_time" do
    it "formats seconds into HH:MM format" do
      # 1 hour and 30 minutes in seconds
      expect(helper.format_spent_time(5400)).to eq("01:30")
    end

    it "formats hours with leading zeros" do
      # 30 minutes in seconds
      expect(helper.format_spent_time(1800)).to eq("00:30")
    end

    it "formats minutes with leading zeros" do
      # 1 hour and 5 minutes in seconds
      expect(helper.format_spent_time(3900)).to eq("01:05")
    end

    it "handles large time values" do
      # 25 hours and 45 minutes in seconds
      expect(helper.format_spent_time(92_700)).to eq("25:45")
    end

    it "handles zero time values" do
      expect(helper.format_spent_time(0)).to eq("00:00")
    end
  end
end
