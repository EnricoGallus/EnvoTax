# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    attributes_for(:user)
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  before do
    sign_in user
  end

  describe "GET /edit" do
    it "renders a successful response" do
      user = create(:user)

      get edit_account_url(user)

      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "Test User" }
      end
      let(:user) { create(:user) }

      before do
        patch account_url(user), params: { user: new_attributes }
        user.reload
      end

      it "updates the requested user name" do
        expect(user.name).to eq(new_attributes[:name])
      end

      it "redirects to the root" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        user = create(:user)
        patch account_path(user), params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
