# frozen_string_literal: true

require "rails_helper"

RSpec.describe ClientPolicy, type: :policy do
  subject(:policy) { described_class.new(user, client) }

  let(:user) { create(:user) }
  let(:client) { create(:client, user: user) }

  describe "permissions" do
    context "when user is the owner of the client" do
      it do
        expect(policy).to permit_only_actions(%i[index show create edit update new destroy])
      end
    end

    context "when user is not the owner of the client" do
      let(:client) { create(:client) }

      it do
        expect(policy).to permit_only_actions(%i[index create new])
      end
    end
  end

  describe "scope" do
    it "includes only the user's clients" do
      expect(ClientPolicy::Scope.new(user, Client.all).resolve).to include(client)
    end

    it "does not include clients other than the user's clients" do
      user = create(:user)
      expect(ClientPolicy::Scope.new(user, Client.all).resolve).not_to include(client)
    end
  end
end
