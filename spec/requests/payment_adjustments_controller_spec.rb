# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentAdjustmentsController, type: :request do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:valid_attributes) do
    attributes_for(:payment_adjustment).merge(user_id: user.id, client_id: client.id)
  end

  let(:invalid_attributes) do
    { amount: -1, date: nil, description: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      PaymentAdjustment.create! valid_attributes
      get payment_adjustments_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      payment_adjustment = PaymentAdjustment.create! valid_attributes
      get payment_adjustment_url(payment_adjustment)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_payment_adjustment_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      payment_adjustment = PaymentAdjustment.create! valid_attributes
      get edit_payment_adjustment_url(payment_adjustment)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PaymentAdjustment" do
        expect do
          post payment_adjustments_url, params: { payment_adjustment: valid_attributes }
        end.to change(PaymentAdjustment, :count).by(1)
      end

      it "redirects to the created payment_adjustment" do
        post payment_adjustments_url, params: { payment_adjustment: valid_attributes }
        expect(response).to redirect_to(payment_adjustment_url(PaymentAdjustment.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PaymentAdjustment" do
        expect do
          post payment_adjustments_url, params: { payment_adjustment: invalid_attributes }
        end.not_to change(PaymentAdjustment, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post payment_adjustments_url, params: { payment_adjustment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { amount: 1000, date: Date.yesterday }
      end

      it "updates the requested payment_adjustment" do
        payment_adjustment = PaymentAdjustment.create! valid_attributes
        patch payment_adjustment_url(payment_adjustment), params: { payment_adjustment: new_attributes }
        payment_adjustment.reload

        expect(payment_adjustment.amount_cents).to eq(new_attributes[:amount])
        expect(payment_adjustment.date).to eq(new_attributes[:date])
      end

      it "redirects to the payment_adjustment" do
        payment_adjustment = PaymentAdjustment.create! valid_attributes
        patch payment_adjustment_url(payment_adjustment), params: { payment_adjustment: new_attributes }
        payment_adjustment.reload
        expect(response).to redirect_to(payment_adjustment_url(payment_adjustment))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        payment_adjustment = PaymentAdjustment.create! valid_attributes
        patch payment_adjustment_url(payment_adjustment), params: { payment_adjustment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested payment_adjustment" do
      payment_adjustment = PaymentAdjustment.create! valid_attributes
      expect do
        delete payment_adjustment_url(payment_adjustment)
      end.to change(PaymentAdjustment, :count).by(-1)
    end

    it "redirects to the payment_adjustments list" do
      payment_adjustment = PaymentAdjustment.create! valid_attributes
      delete payment_adjustment_url(payment_adjustment)
      expect(response).to redirect_to(payment_adjustments_url)
    end
  end
end
