# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/index", type: :view do
  before do
    assign(:expenses, [
             Expense.create!(
               client: nil,
               project: nil,
               amount: "9.99",
               category: 2,
               description: "MyText"
             ),
             Expense.create!(
               client: nil,
               project: nil,
               amount: "9.99",
               category: 2,
               description: "MyText"
             )
           ])
  end

  it "renders a list of expenses" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99"), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText"), count: 2
  end
end
