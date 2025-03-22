# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cost_types/show", type: :view do
  before do
    assign(:cost_type, CostType.create!(
                         name: "Name"
                       ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
