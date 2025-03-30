# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contract_instances/index", type: :view do
  before do
    assign(:contract_instances, [
             ContractInstance.create!(
               contract: nil,
               budget_limit_cents: 2,
               budget_limit_currency: "Budget Limit Currency"
             ),
             ContractInstance.create!(
               contract: nil,
               budget_limit_cents: 2,
               budget_limit_currency: "Budget Limit Currency"
             )
           ])
  end

  it "renders a list of contract_instances" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Budget Limit Currency"), count: 2
  end
end
