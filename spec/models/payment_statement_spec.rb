# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentStatement, type: :model do
  subject(:payment_statement) { build(:payment_statement) }

  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:payment_allocations).dependent(:destroy) }
    it { is_expected.to have_one_attached(:receipt) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:received_on) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, partially_distributed: 1, distributed: 2) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:payment_statement)).to be_valid
    end
  end

  describe "callbacks" do
    describe "after_initialize" do
      it "sets default status to pending for new records" do
        payment_statement = described_class.new
        expect(payment_statement.status).to eq("pending")
      end

      it "doesn't change status for persisted records" do
        payment_statement = create(:payment_statement, status: :distributed)
        reloaded = described_class.find(payment_statement.id)
        expect(reloaded.status).to eq("distributed")
      end
    end
  end

  describe "#allocated_amount" do
    it "returns the sum of all payment allocations" do
      payment_statement = create(:payment_statement)
      create(:payment_allocation, payment_statement: payment_statement, amount: 20_000)
      create(:payment_allocation, payment_statement: payment_statement, amount: 30_000)

      expect(payment_statement.allocated_amount).to eq(Money.new(50_000))
    end

    it "returns 0 when there are no allocations" do
      payment_statement = create(:payment_statement)
      expect(payment_statement.allocated_amount).to eq(Money.new(0))
    end
  end

  describe "#unallocated_amount" do
    it "returns the difference between total amount and allocated amount" do
      payment_statement = create(:payment_statement, amount: 100_000)
      create(:payment_allocation, payment_statement: payment_statement, amount: 30_000)
      create(:payment_allocation, payment_statement: payment_statement, amount: 20_000)

      expect(payment_statement.unallocated_amount).to eq(Money.new(50_000))
    end

    it "returns the full amount when there are no allocations" do
      payment_statement = create(:payment_statement, amount: 100_000)
      expect(payment_statement.unallocated_amount).to eq(Money.new(100_000))
    end
  end

  describe "#update_status!" do
    let(:payment_statement) { create(:payment_statement, amount: 100_000) }

    context "when there are no payment allocations" do
      it "sets status to pending" do
        payment_statement.update(status: :distributed)
        payment_statement.update_status!
        expect(payment_statement.reload).to be_pending
      end
    end

    context "when all amount is allocated" do
      before do
        create(:payment_allocation, payment_statement: payment_statement, amount: payment_statement.unallocated_amount)
      end

      it "sets status to distributed" do
        payment_statement.update_status!
        expect(payment_statement.reload).to be_distributed
      end
    end

    context "when part of the amount is allocated" do
      before do
        create(:payment_allocation, payment_statement: payment_statement, amount: 40_000)
      end

      it "sets status to partially_distributed" do
        payment_statement.update_status!
        expect(payment_statement.reload).to be_partially_distributed
      end
    end
  end
end
