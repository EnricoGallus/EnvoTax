# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/new", type: :view do
  let(:payment_statement) { create(:payment_statement) }

  before do
    assign(:payment_allocation, PaymentAllocation.new)
    assign(:payment_statement, payment_statement)
    render
  end

  it "renders new payment_allocation form" do
    assert_select "form[action=?][method=?]", payment_statement_payment_allocations_path(payment_statement), "post" do
      assert_select "input[name=?]", "payment_allocation[amount]"

      assert_select "select[name=?]", "payment_allocation[income_tax_id]"

      assert_select "select[name=?]", "payment_allocation[allocate_to]"
    end
  end
end
