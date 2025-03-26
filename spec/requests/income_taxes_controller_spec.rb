# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/income_taxes", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    attributes_for(:income_tax)
  end

  let(:invalid_attributes) do
    { tax_type: nil, tax_rate: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      IncomeTax.create! valid_attributes
      get income_taxes_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      income_tax = IncomeTax.create! valid_attributes
      get income_tax_url(income_tax)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_income_tax_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      income_tax = IncomeTax.create! valid_attributes
      get edit_income_tax_url(income_tax)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new IncomeTax" do
        expect do
          post income_taxes_url, params: { income_tax: valid_attributes }
        end.to change(IncomeTax, :count).by(1)
      end

      it "redirects to the created income_tax" do
        post income_taxes_url, params: { income_tax: valid_attributes }
        expect(response).to redirect_to(income_tax_url(IncomeTax.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new IncomeTax" do
        expect do
          post income_taxes_url, params: { income_tax: invalid_attributes }
        end.not_to change(IncomeTax, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post income_taxes_url, params: { income_tax: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { tax_type: "New Tax Type", tax_rate: 0.5 }
      end

      it "updates the requested income_tax" do
        income_tax = IncomeTax.create! valid_attributes
        patch income_tax_url(income_tax), params: { income_tax: new_attributes }
        income_tax.reload

        expect(income_tax.tax_type).to eq new_attributes[:tax_type]
        expect(income_tax.tax_rate).to eq new_attributes[:tax_rate]
      end

      it "redirects to the income_tax" do
        income_tax = IncomeTax.create! valid_attributes
        patch income_tax_url(income_tax), params: { income_tax: new_attributes }
        income_tax.reload
        expect(response).to redirect_to(income_tax_url(income_tax))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        income_tax = IncomeTax.create! valid_attributes
        patch income_tax_url(income_tax), params: { income_tax: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested income_tax" do
      income_tax = IncomeTax.create! valid_attributes
      expect do
        delete income_tax_url(income_tax)
      end.to change(IncomeTax, :count).by(-1)
    end

    it "redirects to the income_taxes list" do
      income_tax = IncomeTax.create! valid_attributes
      delete income_tax_url(income_tax)
      expect(response).to redirect_to(income_taxes_url)
    end
  end
end
