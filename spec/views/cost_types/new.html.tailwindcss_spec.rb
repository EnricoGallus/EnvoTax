# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cost_types/new", type: :view do
  before do
    assign(:cost_type, CostType.new(
                         name: "MyString"
                       ))
  end

  it "renders new cost_type form" do
    render

    assert_select "form[action=?][method=?]", cost_types_path, "post" do
      assert_select "input[name=?]", "cost_type[name]"
    end
  end
end
