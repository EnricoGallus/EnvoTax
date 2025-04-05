# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/edit", type: :view do
  let(:expense) { create(:expense) }

  before do
    assign(:expense, expense)
  end

  it "renders the edit expense form" do
    render

    assert_select "form[action=?][method=?]", expense_path(expense), "post" do
      assert_select "select[name=?]", "expense[contract_instance_id]"

      assert_select "input[name=?]", "expense[amount]"

      assert_select "input[name=?]", "expense[date]"

      assert_select "select[name=?]", "expense[cost_type_id]"
    end
  end
end
