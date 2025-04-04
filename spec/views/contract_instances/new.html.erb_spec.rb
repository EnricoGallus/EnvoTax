# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contract_instances/new", type: :view do
  let(:contract) { create(:contract) }

  before do
    assign(:contract_instance, ContractInstance.new)
    assign(:contract, contract)
  end

  it "renders new contract_instance form" do
    render

    assert_select "form[action=?][method=?]", contract_contract_instances_path(contract), "post" do
      assert_select "input[name=?]", "contract_instance[start_date]"
      assert_select "input[name=?]", "contract_instance[end_date]"

      assert_select "input[name=?]", "contract_instance[budget_limit]"
    end
  end
end
