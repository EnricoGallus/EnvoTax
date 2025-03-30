# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contract_instances/show", type: :view do
  before do
    assign(:contract_instance, ContractInstance.create!(
                                 contract: nil,
                                 budget_limit_cents: 2,
                                 budget_limit_currency: "Budget Limit Currency"
                               ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Budget Limit Currency/)
  end
end
