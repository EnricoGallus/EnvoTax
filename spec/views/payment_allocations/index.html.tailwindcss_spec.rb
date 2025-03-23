# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/index", type: :view do
  before do
    assign(:payment_allocations, [
             PaymentAllocation.create!(
               amount: "9.99",
               tax: nil,
               payment_statement: nil,
               reference: nil
             ),
             PaymentAllocation.create!(
               amount: "9.99",
               tax: nil,
               payment_statement: nil,
               reference: nil
             )
           ])
  end

  it "renders a list of payment_allocations" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("9.99"), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
