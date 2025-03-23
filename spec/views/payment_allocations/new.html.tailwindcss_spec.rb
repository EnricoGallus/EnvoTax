# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/new", type: :view do
  before do
    assign(:payment_allocation, PaymentAllocation.new(
                                  amount: "9.99",
                                  tax: nil,
                                  payment_statement: nil,
                                  reference: nil
                                ))
  end

  it "renders new payment_allocation form" do
    render

    assert_select "form[action=?][method=?]", payment_allocations_path, "post" do
      assert_select "input[name=?]", "payment_allocation[amount]"

      assert_select "input[name=?]", "payment_allocation[tax_id]"

      assert_select "input[name=?]", "payment_allocation[payment_statement_id]"

      assert_select "input[name=?]", "payment_allocation[reference_id]"
    end
  end
end
