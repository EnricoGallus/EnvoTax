# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contract_instances/edit", type: :view do
  let(:contract_instance) do
    ContractInstance.create!(
      contract: nil,
      budget_limit_cents: 1,
      budget_limit_currency: "MyString"
    )
  end

  before do
    assign(:contract_instance, contract_instance)
  end

  it "renders the edit contract_instance form" do
    render

    assert_select "form[action=?][method=?]", contract_instance_path(contract_instance), "post" do
      assert_select "input[name=?]", "contract_instance[contract_id]"

      assert_select "input[name=?]", "contract_instance[budget_limit_cents]"

      assert_select "input[name=?]", "contract_instance[budget_limit_currency]"
    end
  end
end
