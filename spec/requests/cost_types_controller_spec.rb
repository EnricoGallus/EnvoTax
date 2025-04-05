# frozen_string_literal: true

require "rails_helper"

RSpec.describe CostTypesController, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    attributes_for(:cost_type)
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      CostType.create! valid_attributes
      get cost_types_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      cost_type = CostType.create! valid_attributes
      get cost_type_url(cost_type)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_cost_type_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      cost_type = CostType.create! valid_attributes
      get edit_cost_type_url(cost_type)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new CostType" do
        expect do
          post cost_types_url, params: { cost_type: valid_attributes }
        end.to change(CostType, :count).by(1)
      end

      it "redirects to the created cost_type" do
        post cost_types_url, params: { cost_type: valid_attributes }
        expect(response).to redirect_to(cost_type_url(CostType.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new CostType" do
        expect do
          post cost_types_url, params: { cost_type: invalid_attributes }
        end.not_to change(CostType, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post cost_types_url, params: { cost_type: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: Faker::Name.unique.name }
      end

      it "updates the requested cost_type" do
        cost_type = CostType.create! valid_attributes
        patch cost_type_url(cost_type), params: { cost_type: new_attributes }
        cost_type.reload

        expect(cost_type.name).to eq(new_attributes[:name])
      end

      it "redirects to the cost_type" do
        cost_type = CostType.create! valid_attributes
        patch cost_type_url(cost_type), params: { cost_type: new_attributes }
        cost_type.reload
        expect(response).to redirect_to(cost_type_url(cost_type))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        cost_type = CostType.create! valid_attributes
        patch cost_type_url(cost_type), params: { cost_type: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested cost_type" do
      cost_type = CostType.create! valid_attributes
      expect do
        delete cost_type_url(cost_type)
      end.to change(CostType, :count).by(-1)
    end

    it "redirects to the cost_types list" do
      cost_type = CostType.create! valid_attributes
      delete cost_type_url(cost_type)
      expect(response).to redirect_to(cost_types_url)
    end
  end
end
