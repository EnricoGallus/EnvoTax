# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/index", type: :view do
  before do
    assign(:payment_statements, [
             PaymentStatement.create!(
               client: nil,
               user: nil,
               amount: "9.99",
               status: "Status"
             ),
             PaymentStatement.create!(
               client: nil,
               user: nil,
               amount: "9.99",
               status: "Status"
             )
           ])
  end

  it "renders a list of payment_statements" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99"), count: 2
    assert_select cell_selector, text: Regexp.new("Status"), count: 2
  end
end
