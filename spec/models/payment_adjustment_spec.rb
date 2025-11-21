# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentAdjustment, type: :model do
  subject(:payment_adjustment) { build(:payment_adjustment) }

  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:payment_allocations).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, partially_paid: 1, paid: 2, canceled: 3) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:payment_adjustment)).to be_valid
    end
  end

  describe "scopes" do
    context "when unpaid" do
      subject(:unpaid) { described_class.unpaid }

      let!(:pending) { create(:payment_adjustment, status: :pending) }
      let!(:partially_paid) { create(:payment_adjustment, status: :partially_paid) }
      let!(:canceled) { create(:payment_adjustment, status: :canceled) }
      let!(:paid) { create(:payment_adjustment, status: :paid) }

      it "does not include paid records" do
        expect(unpaid).not_to include(paid)
      end

      it "includes all other statuses" do
        expect(unpaid).to include(pending, partially_paid, canceled)
      end
    end
  end

  describe "callbacks" do
    context "when initialized" do
      it "sets default status to pending for new records" do
        payment_adjustment = described_class.new
        expect(payment_adjustment.status).to eq("pending")
      end

      it "does not change status for persisted records" do
        payment_adjustment = create(:payment_adjustment, status: :paid)
        reloaded = described_class.find(payment_adjustment.id)
        expect(reloaded.status).to eq("paid")
      end
    end
  end

  describe "#update_status_from_allocations!" do
    let(:payment_adjustment) { create(:payment_adjustment, amount: 1000, status: :pending) }

    context "when no allocations exist" do
      it "updates status to pending" do
        allow(payment_adjustment).to receive_messages(payment_allocations: [], allocated_amount: 0)

        payment_adjustment.update_status_from_allocations!

        expect(payment_adjustment.reload).to be_pending
      end
    end

    context "when fully allocated" do
      it "updates status to paid" do
        allow(payment_adjustment).to receive_messages(payment_allocations: [double], allocated_amount: Money.new(1000))

        payment_adjustment.update_status_from_allocations!

        expect(payment_adjustment.reload).to be_paid
      end
    end

    context "when partially allocated" do
      it "updates status to partially_paid" do
        allow(payment_adjustment).to receive_messages(payment_allocations: [double], allocated_amount: Money.new(500))

        payment_adjustment.update_status_from_allocations!

        expect(payment_adjustment.reload).to be_partially_paid
      end
    end
  end

  describe ".ransackable_attributes" do
    it "returns allowed attributes for ransack" do
      expect(described_class.ransackable_attributes).to match_array(
        %w[amount client_id date description id status]
      )
    end
  end

  describe ".ransackable_associations" do
    it "returns allowed associations for ransack" do
      expect(described_class.ransackable_associations).to contain_exactly("client")
    end
  end
end
