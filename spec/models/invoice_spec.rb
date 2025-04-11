# frozen_string_literal: true

require "rails_helper"

RSpec.describe Invoice, type: :model do
  subject(:invoice) { build(:invoice) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:contract_instance) }
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
      now = Time.zone.now.at_noon
      create(:time_entry, invoice: invoice, time_from: now - 2.hours, time_to: now, project: project_one)
      create(:time_entry, invoice: invoice, time_from: now - 5.hours, time_to: now - 2.hours, project: project_two)
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
        allow(invoice).to receive_messages(total_amount: 1000, allocated_amount: 1000)

        invoice.update_status_from_allocations!

        expect(invoice.reload).to be_paid
      end
    end

    context "when partially paid" do
      it "updates status to partially_paid" do
        allow(invoice).to receive_messages(total_amount: 1000, allocated_amount: 500)

        invoice.update_status_from_allocations!

        expect(invoice.reload.status).to eq("partially_paid")
      end
    end

    context "when was paid but allocation is removed" do
      it "updates status to sent" do
        invoice.update(status: :paid)
        allow(invoice).to receive_messages(total_amount: Money.new(1000), allocated_amount: Money.new(0))

        invoice.update_status_from_allocations!

        expect(invoice.reload).to be_sent
      end
    end
  end

  describe ".ransackable_attributes" do
    it "returns allowed attributes for ransack" do
      expect(described_class.ransackable_attributes).to match_array(
        %w[contract_id end_date id invoice_date start_date status user_id]
      )
    end
  end

  describe "#clear_generated_errors_for_job_save" do
    it "clears specific errors when validation context is job" do
      invoice = build(:invoice, contract_instance: nil, user: nil, status: nil)
      invoice.valid?(:job)

      expect(invoice.errors).not_to include(:contract_instance)
      expect(invoice.errors).not_to include(:user)
      expect(invoice.errors).not_to include(:status)
    end

    it "keeps errors for normal validation" do
      invoice = build(:invoice, contract_instance: nil, user: nil, status: nil)
      invoice.valid?

      expect(invoice.errors).to include(:contract_instance)
      expect(invoice.errors).to include(:user)
      expect(invoice.errors).to include(:status)
    end
  end

  describe "#generate_invoice_number" do
    it "generates invoice number with format YYYY-MM-XXX" do
      invoice = build(:invoice, invoice_date: Date.new(2025, 6, 15))
      invoice.save

      expect(invoice.invoice_number).to match(/^202506-\d{3}$/)
    end

    it "increments sequence number for invoices in same month" do
      july_invoice = create(:invoice, invoice_date: Date.new(2025, 7, 10))
      expect(july_invoice.invoice_number).to eq("202507-001")

      other_july_invoice = create(:invoice, invoice_date: Date.new(2025, 7, 20))
      expect(other_july_invoice.invoice_number).to eq("202507-002")

      other_year_invoice = create(:invoice, invoice_date: Date.new(2024, 7, 20))
      expect(other_year_invoice.invoice_number).to eq("202407-001")

      august_invoice = create(:invoice, invoice_date: Date.new(2025, 8, 5))
      expect(august_invoice.invoice_number).to eq("202508-003")

      december_invoice = create(:invoice, invoice_date: Date.new(2025, 12, 31))
      expect(december_invoice.invoice_number).to eq("202512-004")
    end
  end
end
