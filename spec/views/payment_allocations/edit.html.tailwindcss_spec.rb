# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/edit", type: :view do
  let(:payment_allocation) do
    PaymentAllocation.create!(
      amount: "9.99",
      tax: nil,
      payment_statement: nil,
      reference: nil
    )
  end

  before do
    assign(:payment_allocation, payment_allocation)
  end

  it "renders the edit payment_allocation form" do
    render

    assert_select "form[action=?][method=?]", payment_allocation_path(payment_allocation), "post" do
      assert_select "input[name=?]", "payment_allocation[amount]"

      assert_select "input[name=?]", "payment_allocation[tax_id]"

      assert_select "input[name=?]", "payment_allocation[payment_statement_id]"

      assert_select "input[name=?]", "payment_allocation[reference_id]"
    end
  end
end
