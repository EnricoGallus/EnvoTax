# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentStatementsController, type: :request do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:valid_attributes) do
    attributes_for(:payment_statement).merge(user_id: user.id, client_id: client.id)
  end

  let(:invalid_attributes) do
    { amount: -1, received_on: nil, description: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      PaymentStatement.create! valid_attributes
      get payment_statements_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      payment_statement = PaymentStatement.create! valid_attributes
      get payment_statement_url(payment_statement)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_payment_statement_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      payment_statement = PaymentStatement.create! valid_attributes
      get edit_payment_statement_url(payment_statement)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PaymentStatement" do
        expect do
          post payment_statements_url, params: { payment_statement: valid_attributes }
        end.to change(PaymentStatement, :count).by(1)
      end

      it "redirects to the created payment_statement" do
        post payment_statements_url, params: { payment_statement: valid_attributes }
        expect(response).to redirect_to(payment_statement_url(PaymentStatement.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PaymentStatement" do
        expect do
          post payment_statements_url, params: { payment_statement: invalid_attributes }
        end.not_to change(PaymentStatement, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post payment_statements_url, params: { payment_statement: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { received_on: Date.yesterday, amount: 1000 }
      end

      it "updates the requested payment_statement" do
        payment_statement = PaymentStatement.create! valid_attributes
        patch payment_statement_url(payment_statement), params: { payment_statement: new_attributes }
        payment_statement.reload

        expect(payment_statement.received_on).to eq(new_attributes[:received_on])
        expect(payment_statement.amount_cents).to eq(new_attributes[:amount])
      end

      it "redirects to the payment_statement" do
        payment_statement = PaymentStatement.create! valid_attributes
        patch payment_statement_url(payment_statement), params: { payment_statement: new_attributes }
        payment_statement.reload
        expect(response).to redirect_to(payment_statement_url(payment_statement))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        payment_statement = PaymentStatement.create! valid_attributes
        patch payment_statement_url(payment_statement), params: { payment_statement: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested payment_statement" do
      payment_statement = PaymentStatement.create! valid_attributes
      expect do
        delete payment_statement_url(payment_statement)
      end.to change(PaymentStatement, :count).by(-1)
    end

    it "redirects to the payment_statements list" do
      payment_statement = PaymentStatement.create! valid_attributes
      delete payment_statement_url(payment_statement)
      expect(response).to redirect_to(payment_statements_url)
    end
  end
end
