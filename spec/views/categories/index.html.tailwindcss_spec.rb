# frozen_string_literal: true

require "rails_helper"

RSpec.describe "categories/index", type: :view do
  before do
    assign(:categories, [
             Category.create!(
               name: "Name"
             ),
             Category.create!(
               name: "Name"
             )
           ])
  end

  it "renders a list of categories" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Name"), count: 2
  end
end
