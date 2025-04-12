# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvoicePolicy, type: :policy do
  subject(:policy) { described_class.new(user, invoice) }

  let(:user) { create(:user) }
  let(:invoice) { create(:invoice, user: user) }

  describe "permissions" do
    context "when user is the owner" do
      it do
        expect(policy).to permit_only_actions(%i[index show create new destroy approve preview])
        expect(policy).to forbid_only_actions(%i[edit update])
      end
    end

    context "when invoice is approved" do
      let(:invoice) { create(:invoice, :approved, user: user) }

      it do
        expect(policy).to permit_only_actions(%i[index show create new preview])
        expect(policy).to forbid_only_actions(%i[edit update approve destroy])
      end
    end

    context "when user is not the owner" do
      let(:invoice) { create(:invoice) }

      it do
        expect(policy).to permit_only_actions(%i[index create new])
      end
    end
  end

  describe "scope" do
    it "includes only the user's contracts" do
      expect(InvoicePolicy::Scope.new(user, Invoice.all).resolve).to include(invoice)
    end

    it "does not include contracts of others" do
      user = create(:user)
      expect(InvoicePolicy::Scope.new(user, Invoice.all).resolve).not_to include(invoice)
    end
  end
end
