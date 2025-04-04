# frozen_string_literal: true

require "rails_helper"

RSpec.describe "income_taxes/index", type: :view do
  before do
    assign(:income_taxes, create_list(:income_tax, 2))
    assign(:q, IncomeTax.ransack)
  end

  it "renders a list of income_taxes" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Tax Type"), count: 2
    assert_select cell_selector, text: Regexp.new("9.99"), count: 2
  end
end
