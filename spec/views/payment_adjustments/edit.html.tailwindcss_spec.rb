# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/edit", type: :view do
  let(:payment_adjustment) do
    PaymentAdjustment.create!(
      client: nil,
      user: nil,
      amount: "9.99",
      description: "MyString",
      status: 1
    )
  end

  before do
    assign(:payment_adjustment, payment_adjustment)
  end

  it "renders the edit payment_adjustment form" do
    render

    assert_select "form[action=?][method=?]", payment_adjustment_path(payment_adjustment), "post" do
      assert_select "input[name=?]", "payment_adjustment[client_id]"

      assert_select "input[name=?]", "payment_adjustment[user_id]"

      assert_select "input[name=?]", "payment_adjustment[amount]"

      assert_select "input[name=?]", "payment_adjustment[description]"

      assert_select "input[name=?]", "payment_adjustment[status]"
    end
  end
end
