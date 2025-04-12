# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  subject(:policy) { described_class.new(user, project) }

  let(:user) { create(:user) }
  let(:project) { create(:project) }

  describe "permissions" do
    it do
      expect(policy).to permit_only_actions(%i[index show create edit update new destroy])
    end
  end
end
