# frozen_string_literal: true

require "rails_helper"

RSpec.describe TimeEntry, type: :model do
  subject(:time_entry) { build(:time_entry) }

  describe "associations" do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:invoice).optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:time_from) }
    it { is_expected.to validate_presence_of(:time_to) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:time_entry)).to be_valid
    end
  end

  describe "#spent_time_in_seconds" do
    it "calculates the time difference in seconds" do
      time_from = Time.zone.now
      time_to = time_from + 2.hours + 30.minutes
      time_entry = build(:time_entry, time_from: time_from, time_to: time_to)

      expect(time_entry.spent_time_in_seconds).to eq(9000) # 2.5 hours in seconds
    end
  end

  describe "#spent_time" do
    it "formats the spent time as HH:MM" do
      time_from = Time.zone.now
      time_to = time_from + 2.hours + 30.minutes
      time_entry = build(:time_entry, time_from: time_from, time_to: time_to)

      expect(time_entry.spent_time).to eq("02:30")
    end
  end

  describe "#calculate_cost" do
    it "calculates the cost based on spent time and project hourly rate" do
      client = build(:client, hourly_rate: 100)
      project = build(:project, client: client)
      time_from = Time.zone.now
      time_to = time_from + 2.hours + 30.minutes
      time_entry = build(:time_entry, project: project, time_from: time_from, time_to: time_to)

      # 2.5 hours * $100/hour = $250
      expect(time_entry.calculate_cost).to eq(Money.new(250))
    end
  end

  describe ".ransackable_attributes" do
    it "returns allowed attributes for ransack" do
      expect(described_class.ransackable_attributes).to match_array(
        %w[date invoice_id name project_id time_from time_to]
      )
    end
  end

  describe ".ransackable_associations" do
    it "returns allowed associations for ransack" do
      expect(described_class.ransackable_associations).to match_array(
        %w[invoice project]
      )
    end
  end
end
