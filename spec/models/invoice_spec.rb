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
      expect(invoice).to define_enum_for(:status).with_values(draft: 0, approved: 1, partially_paid: 2, paid: 3,
                                                              overdue: 4)
    }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(invoice).to be_valid
    end
  end

  describe "#update_status_from_allocations!" do
    let(:invoice) { create(:invoice, status: :approved) }

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
      it "updates status to paid" do
        invoice.update(status: :paid)
        allow(invoice).to receive_messages(total_amount: Money.new(1000), allocated_amount: Money.new(0))

        invoice.update_status_from_allocations!

        expect(invoice.reload).to be_approved
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

  describe "#generate_invoice_number" do
    it "generates invoice number with format YYYY-XXXX" do
      invoice = build(:invoice, invoice_date: Date.new(2025, 6, 15))
      invoice.save

      expect(invoice.invoice_number).to match(/^2025-\d{4}$/)
    end

    it "increments sequence number for invoices in same month" do
      client = create(:client)
      july_invoice = create(:invoice, client: client, invoice_date: Date.new(2025, 7, 10))
      expect(july_invoice.invoice_number).to eq("2025-0001")

      other_july_invoice = create(:invoice, client: client, invoice_date: Date.new(2025, 7, 20))
      expect(other_july_invoice.invoice_number).to eq("2025-0002")

      different_july_invoice = create(:invoice, invoice_date: Date.new(2025, 7, 20))
      expect(different_july_invoice.invoice_number).to eq("2025-0001")

      other_year_invoice = create(:invoice, client: client, invoice_date: Date.new(2024, 7, 20))
      expect(other_year_invoice.invoice_number).to eq("2024-0001")

      august_invoice = create(:invoice, client: client, invoice_date: Date.new(2025, 8, 5))
      expect(august_invoice.invoice_number).to eq("2025-0003")

      december_invoice = create(:invoice, client: client, invoice_date: Date.new(2025, 12, 31))
      expect(december_invoice.invoice_number).to eq("2025-0004")
    end
  end
end
