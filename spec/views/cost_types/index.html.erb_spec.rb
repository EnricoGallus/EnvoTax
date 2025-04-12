# frozen_string_literal: true

require "rails_helper"

RSpec.describe "cost_types/index", type: :view do
  let(:user) { create(:user) }
  let(:cost_types) { create_list(:cost_type, 2, user: user) }

  before do
    assign(:cost_types, cost_types)
    assign(:q, CostType.ransack)
    enable_pundit(view, user)
    render
  end

  it "renders a list of cost_types" do
    assert_select "#cost_types" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_details(element, cost_types[index]) }
      end
    end
  end

  private

  def assert_details(element, cost_type)
    assert_select element, "td", text: cost_type.name, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
