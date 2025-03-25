# frozen_string_literal: true

require "rails_helper"

RSpec.describe Invoice, type: :model do
  subject(:invoice) { build(:invoice) }

  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:time_entries).dependent(:nullify) }
    it { is_expected.to have_many(:expenses).dependent(:nullify) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:invoice_date) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe "enums" do
    it {
      expect(invoice).to define_enum_for(:status).with_values(draft: 0, sent: 1, partially_paid: 2, paid: 3, overdue: 4)
    }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(invoice).to be_valid
    end
  end

  describe "#total_amount" do
    let(:invoice) { create(:invoice) }
    let(:client) { create(:client, hourly_rate: 100) }
    let(:project_one) { create(:project, client: client) }
    let(:project_two) { create(:project, client: client) }

    it "calculates the sum of time entries cost and expenses amount" do
      create(:time_entry, invoice: invoice, time_from: 2.hours.ago, time_to: Time.zone.now, project: project_one)
      create(:time_entry, invoice: invoice, time_from: 5.hours.ago, time_to: 2.hours.ago, project: project_two)
      create(:expense, invoice: invoice, amount: 75)
      create(:expense, invoice: invoice, amount: 125)
      # Time entries: (2*50) + (3*60) = 100 + 180 = 280
      # Expenses: 75 + 125 = 200
      # Total: 280 + 200 = 480
      expect(invoice.total_amount).to eq(Money.new(700))
    end
  end

  describe "#update_status_from_allocations!" do
    let(:invoice) { create(:invoice, status: :sent) }

    context "when fully paid" do
      it "updates status to paid" do
        allow(invoice).to receive(:total_amount).and_return(1000)
        allow(invoice).to receive(:allocated_amount).and_return(1000)

        invoice.update_status_from_allocations!

        expect(invoice.reload).to be_paid
      end
    end

    context "when partially paid" do
      it "updates status to partially_paid" do
        allow(invoice).to receive(:total_amount).and_return(1000)
        allow(invoice).to receive(:allocated_amount).and_return(500)

        invoice.update_status_from_allocations!

        expect(invoice.reload.status).to eq("partially_paid")
      end
    end

    context "when was paid but allocation is removed" do
      it "updates status to sent" do
        invoice.update(status: :paid)
        allow(invoice).to receive(:total_amount).and_return(Money.new(1000))
        allow(invoice).to receive(:allocated_amount).and_return(Money.new(0))

        invoice.update_status_from_allocations!

        expect(invoice.reload).to be_sent
      end
    end
  end

  describe ".ransackable_attributes" do
    it "returns allowed attributes for ransack" do
      expect(described_class.ransackable_attributes).to match_array(
        %w[client_id created_at end_date id invoice_date start_date status updated_at user_id]
      )
    end
  end

  describe "#clear_generated_errors_for_job_save" do
    it "clears specific errors when validation context is job" do
      invoice = build(:invoice, client: nil, user: nil, status: nil)
      invoice.valid?(:job)

      expect(invoice.errors).not_to include(:client)
      expect(invoice.errors).not_to include(:user)
      expect(invoice.errors).not_to include(:status)
    end

    it "keeps errors for normal validation" do
      invoice = build(:invoice, client: nil, user: nil, status: nil)
      invoice.valid?

      expect(invoice.errors).to include(:client)
      expect(invoice.errors).to include(:user)
      expect(invoice.errors).to include(:status)
    end
  end
end
