# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/new", type: :view do
  before do
    assign(:payment_adjustment, PaymentAdjustment.new)
    render
  end

  it "renders new payment_adjustment form" do
    assert_select "form[action=?][method=?]", payment_adjustments_path, "post" do
      assert_select "input[name=?]", "payment_adjustment[amount]"

      assert_select "input[name=?]", "payment_adjustment[description]"

      assert_select "select[name=?]", "payment_adjustment[client_id]"
    end
  end
end
