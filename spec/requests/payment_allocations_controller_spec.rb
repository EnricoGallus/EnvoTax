# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentAllocationsController, type: :request do
  let(:user) { create(:user) }
  let(:income_tax) { create(:income_tax) }
  let(:payment_statement) { create(:payment_statement) }
  let(:invoice) { create(:invoice) }
  let(:valid_attributes) do
    attributes_for(:payment_allocation).merge(income_tax_id: income_tax.id, reference_id: invoice.id,
                                              reference_type: "Invoice", payment_statement_id: payment_statement.id)
  end

  let(:invalid_attributes) do
    { income_tax_id: nil, amount: -1000 }
  end

  before do
    sign_in user
  end

  describe "GET /show" do
    it "renders a successful response" do
      payment_allocation = PaymentAllocation.create! valid_attributes
      get payment_statement_payment_allocation_url(payment_statement, payment_allocation)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_payment_statement_payment_allocation_url(payment_statement)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      payment_allocation = PaymentAllocation.create! valid_attributes
      get edit_payment_statement_payment_allocation_url(payment_statement, payment_allocation)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PaymentAllocation" do
        expect do
          post payment_statement_payment_allocations_url(payment_statement),
               params: { payment_allocation: valid_attributes }
        end.to change(PaymentAllocation, :count).by(1)
      end

      it "redirects to the created payment statement" do
        post payment_statement_payment_allocations_url(payment_statement),
             params: { payment_allocation: valid_attributes }
        expect(response).to redirect_to(payment_statement_path(payment_statement))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PaymentAllocation" do
        expect do
          post payment_statement_payment_allocations_url(payment_statement),
               params: { payment_allocation: invalid_attributes }
        end.not_to change(PaymentAllocation, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post payment_statement_payment_allocations_url(payment_statement),
             params: { payment_allocation: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { amount: 12_000 }
      end

      it "updates the requested payment_allocation" do
        payment_allocation = PaymentAllocation.create! valid_attributes
        patch payment_statement_payment_allocation_url(payment_statement, payment_allocation),
              params: { payment_allocation: new_attributes }
        payment_allocation.reload

        expect(payment_allocation.amount_cents).to eq(new_attributes[:amount])
      end

      it "redirects to the payment_statement" do
        payment_allocation = PaymentAllocation.create! valid_attributes
        patch payment_statement_payment_allocation_url(payment_statement, payment_allocation),
              params: { payment_allocation: new_attributes }
        payment_allocation.reload
        expect(response).to redirect_to(payment_statement_path(payment_statement))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        payment_allocation = PaymentAllocation.create! valid_attributes
        patch payment_statement_payment_allocation_url(payment_statement, payment_allocation),
              params: { payment_allocation: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested payment_allocation" do
      payment_allocation = PaymentAllocation.create! valid_attributes
      expect do
        delete payment_statement_payment_allocation_url(payment_statement, payment_allocation)
      end.to change(PaymentAllocation, :count).by(-1)
    end

    it "redirects to the payment_statement" do
      payment_allocation = PaymentAllocation.create! valid_attributes
      delete payment_statement_payment_allocation_url(payment_statement, payment_allocation)
      expect(response).to redirect_to(payment_statement_path(payment_statement))
    end
  end
end
