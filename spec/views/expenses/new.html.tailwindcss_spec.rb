# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/new", type: :view do
  before do
    assign(:expense, Expense.new(
                       client: nil,
                       project: nil,
                       amount: "9.99",
                       category: 1,
                       description: "MyText"
                     ))
  end

  it "renders new expense form" do
    render

    assert_select "form[action=?][method=?]", expenses_path, "post" do
      assert_select "input[name=?]", "expense[client_id]"

      assert_select "input[name=?]", "expense[project_id]"

      assert_select "input[name=?]", "expense[amount]"

      assert_select "input[name=?]", "expense[category]"

      assert_select "textarea[name=?]", "expense[description]"
    end
  end
end
