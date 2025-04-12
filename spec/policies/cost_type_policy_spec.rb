# frozen_string_literal: true

require "rails_helper"

RSpec.describe CostTypePolicy, type: :policy do
  subject(:policy) { described_class.new(user, cost_type) }

  let(:user) { create(:user) }
  let(:cost_type) { create(:cost_type, user: user) }

  describe "permissions" do
    context "when user is the owner" do
      it do
        expect(policy).to permit_only_actions(%i[index show create edit update new destroy])
      end
    end

    context "when user is not the owner" do
      let(:cost_type) { create(:cost_type) }

      it do
        expect(policy).to permit_only_actions(%i[index create new])
      end
    end
  end

  describe "scope" do
    it "includes only the user's contracts" do
      expect(CostTypePolicy::Scope.new(user, CostType.all).resolve).to include(cost_type)
    end

    it "does not include contracts of others" do
      user = create(:user)
      expect(CostTypePolicy::Scope.new(user, CostType.all).resolve).not_to include(cost_type)
    end
  end
end
