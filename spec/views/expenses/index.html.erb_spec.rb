# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/index", type: :view do
  let(:expenses) { create_list(:expense, 2) }

  before do
    assign(:expenses, expenses)
    assign(:q, Expense.ransack)
    render
  end

  it "renders a list of expenses" do
    assert_select "#expenses" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_details(element, expenses[index]) }
      end
    end
  end

  private

  def assert_details(element, expense)
    assert_select element, "td", text: expense.amount.format, count: 1
    assert_select element, "td", text: expense.cost_type.name, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
