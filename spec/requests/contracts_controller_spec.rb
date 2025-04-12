# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContractsController, type: :request do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:valid_attributes) do
    attributes_for(:contract).merge(client_id: client.id)
  end

  let(:invalid_attributes) do
    { name: nil, client_id: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      user.contracts.create! valid_attributes
      get contracts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      contract = user.contracts.create! valid_attributes
      get contract_url(contract)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_contract_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      contract = user.contracts.create! valid_attributes
      get edit_contract_url(contract)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Contract" do
        expect do
          post contracts_url, params: { contract: valid_attributes }
        end.to change(Contract, :count).by(1)
      end

      it "redirects to the created contract" do
        post contracts_url, params: { contract: valid_attributes }
        expect(response).to redirect_to(contract_url(Contract.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Contract" do
        expect do
          post contracts_url, params: { contract: invalid_attributes }
        end.not_to change(Contract, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post contracts_url, params: { contract: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "changed name" }
      end

      it "updates the requested contract" do
        contract = user.contracts.create! valid_attributes
        patch contract_url(contract), params: { contract: new_attributes }
        contract.reload

        expect(contract.name).to eq("changed name")
      end

      it "redirects to the contract" do
        contract = user.contracts.create! valid_attributes
        patch contract_url(contract), params: { contract: new_attributes }
        contract.reload
        expect(response).to redirect_to(contract_url(contract))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        contract = user.contracts.create! valid_attributes
        patch contract_url(contract), params: { contract: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested contract" do
      contract = user.contracts.create! valid_attributes
      expect do
        delete contract_url(contract)
      end.to change(Contract, :count).by(-1)
    end

    it "redirects to the contracts list" do
      contract = user.contracts.create! valid_attributes
      delete contract_url(contract)
      expect(response).to redirect_to(contracts_url)
    end
  end
end
