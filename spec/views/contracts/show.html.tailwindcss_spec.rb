# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/show", type: :view do
  before do
    assign(:contract, Contract.create!(
                        name: "Name",
                        client: nil,
                        budget_limit_cents: 2,
                        budget_limit_currency: "Budget Limit Currency",
                        status: 3
                      ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Budget Limit Currency/)
    expect(rendered).to match(/3/)
  end
end
