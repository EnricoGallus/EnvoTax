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

  describe "before_validation: calculate_spent_time_and_cost" do
    it "sets spent_time_in_seconds and cost when times and rates are present" do
      client = build(:client, hourly_rate: 100)
      project = build(:project, client: client)

      entry = build(
        :time_entry,
        name: "Work",
        date: Date.current,
        time_from: Time.zone.parse("10:00"),
        time_to: Time.zone.parse("12:30"),
        project: project
      )

      expect(entry.spent_time_in_seconds).to eq(0)
      expect(entry.cost).to eq(Money.zero)

      expect(entry).to be_valid

      expect(entry.spent_time_in_seconds).to eq(9000) # 2.5h in seconds
      expect(entry.cost).to eq(Money.new(250)) # 2.5 * 100/hr = 250
    end

    it "does not crash and sets zero cost when project or hourly_rate is missing" do
      entry = build(
        :time_entry,
        name: "Work",
        date: Date.current,
        time_from: Time.zone.parse("10:00"),
        time_to: Time.zone.parse("11:00"),
        project: nil
      )

      expect(entry).not_to be_valid # missing project, but callback still runs
      expect(entry.spent_time_in_seconds).to eq(3600)
      expect(entry.cost).to eq(Money.zero)
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

  describe "#no_time_overlap" do
    let(:project) { create(:project) }
    let(:date) { Date.current }

    context "when creating a new time entry" do
      before do
        create(:time_entry,
               project: project,
               date: date,
               time_from: Time.zone.parse("10:00"),
               time_to: Time.zone.parse("12:00"))
      end

      it "prevents overlapping time entries (case 1: entry starts before and ends during)" do
        overlapping_entry = build(:time_entry,
                                  project: project,
                                  date: date,
                                  time_from: Time.zone.parse("09:00"),
                                  time_to: Time.zone.parse("11:00"))

        expect(overlapping_entry).not_to be_valid
        expect(overlapping_entry.errors[:base]).to include(
          I18n.t("activerecord.errors.models.time_entry.attributes.time_overlap.invalid")
        )
      end

      it "prevents overlapping time entries (case 2: entry starts before and ends after)" do
        overlapping_entry = build(:time_entry,
                                  project: project,
                                  date: date,
                                  time_from: Time.zone.parse("09:00"),
                                  time_to: Time.zone.parse("13:00"))

        expect(overlapping_entry).not_to be_valid
      end

      it "prevents overlapping time entries (case 3: entry falls completely within)" do
        overlapping_entry = build(:time_entry,
                                  project: project,
                                  date: date,
                                  time_from: Time.zone.parse("10:30"),
                                  time_to: Time.zone.parse("11:30"))

        expect(overlapping_entry).not_to be_valid
      end

      it "allows adjacent time entries" do
        non_overlapping_entry = build(:time_entry,
                                      project: project,
                                      date: date,
                                      time_from: Time.zone.parse("12:00"),
                                      time_to: Time.zone.parse("14:00"))

        expect(non_overlapping_entry).to be_valid
      end

      it "allows entries on different days" do
        different_day_entry = build(:time_entry,
                                    project: project,
                                    date: date + 1.day,
                                    time_from: Time.zone.parse("10:00"),
                                    time_to: Time.zone.parse("12:00"))

        expect(different_day_entry).to be_valid
      end
    end

    context "when updating an existing time entry" do
      it "excludes itself from the overlap check" do
        entry = create(:time_entry,
                       project: project,
                       date: date,
                       time_from: Time.zone.parse("10:00"),
                       time_to: Time.zone.parse("12:00"))

        entry.name = "Updated name"
        expect(entry).to be_valid
      end
    end
  end
end
