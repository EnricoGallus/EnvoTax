# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cost_types/index", type: :view do
  before do
    assign(:cost_types, [
             CostType.create!(
               name: "Name"
             ),
             CostType.create!(
               name: "Name"
             )
           ])
  end

  it "renders a list of cost_types" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Name"), count: 2
  end
end
