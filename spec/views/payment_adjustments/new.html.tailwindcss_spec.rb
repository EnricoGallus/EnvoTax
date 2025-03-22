# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/new", type: :view do
  before do
    assign(:payment_adjustment, PaymentAdjustment.new(
                                  client: nil,
                                  user: nil,
                                  amount: "9.99",
                                  description: "MyString",
                                  status: 1
                                ))
  end

  it "renders new payment_adjustment form" do
    render

    assert_select "form[action=?][method=?]", payment_adjustments_path, "post" do
      assert_select "input[name=?]", "payment_adjustment[client_id]"

      assert_select "input[name=?]", "payment_adjustment[user_id]"

      assert_select "input[name=?]", "payment_adjustment[amount]"

      assert_select "input[name=?]", "payment_adjustment[description]"

      assert_select "input[name=?]", "payment_adjustment[status]"
    end
  end
end
