# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/index", type: :view do
  before do
    assign(:contracts, [
             Contract.create!(
               name: "Name",
               client: nil,
               budget_limit_cents: 2,
               budget_limit_currency: "Budget Limit Currency",
               status: 3
             ),
             Contract.create!(
               name: "Name",
               client: nil,
               budget_limit_cents: 2,
               budget_limit_currency: "Budget Limit Currency",
               status: 3
             )
           ])
  end

  it "renders a list of contracts" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Name"), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Budget Limit Currency"), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
