# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExpensesController, type: :request do
  let(:user) { create(:user) }
  let(:cost_type) { create(:cost_type) }
  let(:valid_attributes) do
    attributes_for(:expense).merge(cost_type_id: cost_type.id)
  end

  let(:invalid_attributes) do
    { date: nil, amount: -2122, description: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      Expense.create! valid_attributes
      get expenses_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      expense = Expense.create! valid_attributes
      get expense_url(expense)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_expense_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      expense = Expense.create! valid_attributes
      get edit_expense_url(expense)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Expense" do
        expect do
          post expenses_url, params: { expense: valid_attributes }
        end.to change(Expense, :count).by(1)
      end

      it "redirects to the created expense" do
        post expenses_url, params: { expense: valid_attributes }
        expect(response).to redirect_to(expense_url(Expense.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Expense" do
        expect do
          post expenses_url, params: { expense: invalid_attributes }
        end.not_to change(Expense, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post expenses_url, params: { expense: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { amount: 1000, description: "Updated description" }
      end

      it "updates the requested expense" do
        expense = Expense.create! valid_attributes
        patch expense_url(expense), params: { expense: new_attributes }
        expense.reload

        expect(expense.description).to eq(new_attributes[:description])
        expect(expense.amount_cents).to eq(new_attributes[:amount])
      end

      it "redirects to the expense" do
        expense = Expense.create! valid_attributes
        patch expense_url(expense), params: { expense: new_attributes }
        expense.reload
        expect(response).to redirect_to(expense_url(expense))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        expense = Expense.create! valid_attributes
        patch expense_url(expense), params: { expense: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested expense" do
      expense = Expense.create! valid_attributes
      expect do
        delete expense_url(expense)
      end.to change(Expense, :count).by(-1)
    end

    it "redirects to the expenses list" do
      expense = Expense.create! valid_attributes
      delete expense_url(expense)
      expect(response).to redirect_to(expenses_url)
    end
  end
end
