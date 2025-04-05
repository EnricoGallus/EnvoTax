# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvoicesController, type: :request do
  let(:user) { create(:user) }
  let(:contract_instance) { create(:contract_instance) }
  let(:valid_attributes) do
    attributes_for(:invoice).merge(user_id: user.id, contract_instance_id: contract_instance.id)
  end

  let(:invalid_attributes) do
    { invoice_date: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      Invoice.create! valid_attributes
      get invoices_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      invoice = Invoice.create! valid_attributes
      get invoice_url(invoice, format: :pdf)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_invoice_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Invoice" do
        expect do
          post invoices_url, params: { invoice: valid_attributes }
        end.to have_enqueued_job(InvoiceProcessorJob)
        have_enqueued_job(InvoiceProcessorJob)
          .with(hash_including("start_date", "end_date", "invoice_date"), user.id, contract_instance.id)
      end

      it "redirects to the index" do
        post invoices_url, params: { invoice: valid_attributes }
        expect(response).to redirect_to(invoices_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Invoice" do
        expect do
          post invoices_url, params: { invoice: invalid_attributes }
        end.not_to change(Invoice, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post invoices_url, params: { invoice: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested invoice" do
      invoice = Invoice.create! valid_attributes
      expect do
        delete invoice_url(invoice)
      end.to change(Invoice, :count).by(-1)
    end

    it "redirects to the invoices list" do
      invoice = Invoice.create! valid_attributes
      delete invoice_url(invoice)
      expect(response).to redirect_to(invoices_url)
    end
  end
end
