# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentAllocation, type: :model do
  subject(:payment_allocation) { build(:payment_allocation) }

  describe "associations" do
    it { is_expected.to belong_to(:income_tax) }
    it { is_expected.to belong_to(:payment_statement) }
    it { is_expected.to belong_to(:reference) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:payment_allocation)).to be_valid
    end
  end

  describe "callbacks" do
    it "calls update_statuses after save" do
      payment_allocation = build(:payment_allocation)
      expect(payment_allocation).to receive(:update_statuses)
      payment_allocation.save!
    end

    it "calls update_statuses after destroy" do
      payment_allocation = create(:payment_allocation)
      expect(payment_allocation).to receive(:update_statuses)
      payment_allocation.destroy!
    end
  end

  describe "#update_statuses" do
    let(:payment_allocation) { create(:payment_allocation) }

    it "updates the payment statement status" do
      payment_statement = payment_allocation.payment_statement
      expect(payment_statement).to receive(:update_status!)
      payment_allocation.update_statuses
    end

    context "with reference present" do
      it "updates the reference status" do
        reference = payment_allocation.reference
        expect(reference).to receive(:update_status_from_allocations!)
        payment_allocation.update_statuses
      end
    end

    context "without reference" do
      it "doesn't attempt to update reference status" do
        payment_allocation.reference = nil
        expect { payment_allocation.update_statuses }.not_to raise_error
      end
    end
  end
end
