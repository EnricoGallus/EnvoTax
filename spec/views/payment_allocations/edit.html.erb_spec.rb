# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/edit", type: :view do
  let(:payment_allocation) { create(:payment_allocation) }

  before do
    assign(:payment_allocation, payment_allocation)
    assign(:payment_statement, payment_allocation.payment_statement)
    render
  end

  it "renders the edit payment_allocation form" do
    action = payment_statement_payment_allocation_path(payment_allocation.payment_statement, payment_allocation)
    assert_select "form[action=?][method=?]", action, "post" do
      assert_select "input[name=?]", "payment_allocation[amount]"

      assert_select "select[name=?]", "payment_allocation[income_tax_id]"
    end
  end
end
