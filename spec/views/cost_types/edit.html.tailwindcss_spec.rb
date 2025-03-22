# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cost_types/edit", type: :view do
  let(:cost_type) do
    CostType.create!(
      name: "MyString"
    )
  end

  before do
    assign(:cost_type, cost_type)
  end

  it "renders the edit cost_type form" do
    render

    assert_select "form[action=?][method=?]", cost_type_path(cost_type), "post" do
      assert_select "input[name=?]", "cost_type[name]"
    end
  end
end
