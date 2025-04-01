# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContractInstancesController, type: :request do
  let(:user) { create(:user) }
  let(:contract) { create(:contract) }
  let(:valid_attributes) do
    attributes_for(:contract_instance).merge(contract_id: contract.id)
  end

  let(:invalid_attributes) do
    { start_date: nil }
  end

  before do
    sign_in user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_contract_contract_instance_path(contract)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      contract_instance = ContractInstance.create! valid_attributes
      get edit_contract_contract_instance_path(contract, contract_instance)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ContractInstance" do
        expect do
          post contract_contract_instances_path(contract), params: { contract_instance: valid_attributes }
        end.to change(ContractInstance, :count).by(1)
      end

      it "redirects to the contract" do
        post contract_contract_instances_path(contract), params: { contract_instance: valid_attributes }
        expect(response).to redirect_to(contract_path(contract))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ContractInstance" do
        expect do
          post contract_contract_instances_path(contract), params: { contract_instance: invalid_attributes }
        end.not_to change(ContractInstance, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post contract_contract_instances_path(contract), params: { contract_instance: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { start_date: Date.tomorrow, end_date: Date.tomorrow + 1.month }
      end

      it "updates the requested contract_instance" do
        contract_instance = ContractInstance.create! valid_attributes
        patch contract_contract_instance_path(contract, contract_instance),
              params: { contract_instance: new_attributes }
        contract_instance.reload

        expect(contract_instance.start_date).to eq(Date.tomorrow)
      end

      it "redirects to the contract_instance" do
        contract_instance = ContractInstance.create! valid_attributes
        patch contract_contract_instance_path(contract, contract_instance),
              params: { contract_instance: new_attributes }
        contract_instance.reload
        expect(response).to redirect_to(contract_contract_instance_path(contract, contract_instance))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        contract_instance = ContractInstance.create! valid_attributes
        patch contract_contract_instance_path(contract, contract_instance),
              params: { contract_instance: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested contract_instance" do
      contract_instance = ContractInstance.create! valid_attributes
      expect do
        delete contract_contract_instance_path(contract, contract_instance)
      end.to change(ContractInstance, :count).by(-1)
    end

    it "redirects to the contract" do
      contract_instance = ContractInstance.create! valid_attributes
      delete contract_contract_instance_path(contract, contract_instance)
      expect(response).to redirect_to(contract_path(contract))
    end
  end
end
