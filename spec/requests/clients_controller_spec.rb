# frozen_string_literal: true

require "rails_helper"

RSpec.describe ClientsController, type: :request do
  let(:user) { create(:user) }
  let(:client) { create(:client, user: user) }
  let(:valid_attributes) do
    attributes_for(:client).merge(address_attributes: attributes_for(:address))
  end

  let(:invalid_attributes) do
    { name: nil, hourly_rate: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get clients_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get client_url(client)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_client_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_client_url(client)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Client" do
        expect do
          post clients_url, params: { client: valid_attributes }
        end.to change(Client, :count).by(1)
      end

      it "redirects to the created client" do
        post clients_url, params: { client: valid_attributes }
        expect(response).to redirect_to(client_url(Client.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Client" do
        expect do
          post clients_url, params: { client: invalid_attributes }
        end.not_to change(Client, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post clients_url, params: { client: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "Updated Client", hourly_rate: 5000 }
      end

      before do
        patch client_url(client), params: { client: new_attributes }
        client.reload
      end

      it "updates the requested client name" do
        expect(client.name).to eq("Updated Client")
      end

      it "updates the requested client hourly rate" do
        expect(client.hourly_rate).to eq(Money.new(5000))
      end

      it "redirects to the client" do
        expect(response).to redirect_to(client_url(client))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch client_url(client), params: { client: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested client" do
      client = create(:client, user: user)
      expect do
        delete client_url(client)
      end.to change(Client, :count).by(-1)
    end

    it "redirects to the clients list" do
      delete client_url(client)
      expect(response).to redirect_to(clients_url)
    end
  end
end
