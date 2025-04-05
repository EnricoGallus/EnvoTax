# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/new", type: :view do
  before do
    assign(:expense, Expense.new)
  end

  it "renders new expense form" do
    render

    assert_select "form[action=?][method=?]", expenses_path, "post" do
      assert_select "select[name=?]", "expense[contract_instance_id]"

      assert_select "input[name=?]", "expense[amount]"

      assert_select "input[name=?]", "expense[date]"

      assert_select "select[name=?]", "expense[cost_type_id]"
    end
  end
end
