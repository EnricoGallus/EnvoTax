# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/index", type: :view do
  before do
    assign(:payment_adjustments, [
             PaymentAdjustment.create!(
               client: nil,
               user: nil,
               amount: "9.99",
               description: "Description",
               status: 2
             ),
             PaymentAdjustment.create!(
               client: nil,
               user: nil,
               amount: "9.99",
               description: "Description",
               status: 2
             )
           ])
  end

  it "renders a list of payment_adjustments" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99"), count: 2
    assert_select cell_selector, text: Regexp.new("Description"), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
