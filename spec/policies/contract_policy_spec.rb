# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContractPolicy, type: :policy do
  subject(:policy) { described_class.new(user, contract) }

  let(:user) { create(:user) }
  let(:contract) { create(:contract, user: user) }

  describe "permissions" do
    context "when user is the owner" do
      it do
        expect(policy).to permit_only_actions(%i[index show create edit update new destroy])
      end
    end

    context "when user is not the owner" do
      let(:contract) { create(:contract) }

      it do
        expect(policy).to permit_only_actions(%i[index create new])
      end
    end
  end

  describe "scope" do
    it "includes only the user's contracts" do
      expect(ContractPolicy::Scope.new(user, Contract.all).resolve).to include(contract)
    end

    it "does not include contracts of others" do
      user = create(:user)
      expect(ContractPolicy::Scope.new(user, Contract.all).resolve).not_to include(contract)
    end
  end
end
