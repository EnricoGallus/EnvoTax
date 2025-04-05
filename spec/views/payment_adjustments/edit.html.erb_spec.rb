# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/edit", type: :view do
  let(:payment_adjustment) { create(:payment_adjustment) }

  before do
    assign(:payment_adjustment, payment_adjustment)
    render
  end

  it "renders the edit payment_adjustment form" do
    assert_select "form[action=?][method=?]", payment_adjustment_path(payment_adjustment), "post" do
      assert_select "input[name=?]", "payment_adjustment[amount]"

      assert_select "input[name=?]", "payment_adjustment[description]"
    end
  end
end
