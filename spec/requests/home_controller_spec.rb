# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :request do
  describe "GET /index" do
    context "when not logged in" do
      it "returns http success" do
        get root_path
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when logged in" do
      before do
        user = create(:user)
        sign_in user, scope: :user
      end

      it "returns http success" do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
