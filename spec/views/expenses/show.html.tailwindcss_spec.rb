# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/show", type: :view do
  before do
    assign(:expense, Expense.create!(
                       client: nil,
                       project: nil,
                       amount: "9.99",
                       category: 2,
                       description: "MyText"
                     ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
