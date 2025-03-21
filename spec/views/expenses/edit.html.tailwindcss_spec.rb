# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/edit", type: :view do
  let(:expense) do
    Expense.create!(
      client: nil,
      project: nil,
      amount: "9.99",
      category: 1,
      description: "MyText"
    )
  end

  before do
    assign(:expense, expense)
  end

  it "renders the edit expense form" do
    render

    assert_select "form[action=?][method=?]", expense_path(expense), "post" do
      assert_select "input[name=?]", "expense[client_id]"

      assert_select "input[name=?]", "expense[project_id]"

      assert_select "input[name=?]", "expense[amount]"

      assert_select "input[name=?]", "expense[category]"

      assert_select "textarea[name=?]", "expense[description]"
    end
  end
end
