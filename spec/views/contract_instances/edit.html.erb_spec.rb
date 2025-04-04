# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contract_instances/edit", type: :view do
  let(:contract_instance) { create(:contract_instance) }

  before do
    assign(:contract_instance, contract_instance)
    assign(:contract, contract_instance.contract)
  end

  it "renders the edit contract_instance form" do
    render

    assert_select "form[action=?][method=?]",
                  contract_contract_instance_path(contract_instance.contract, contract_instance), "post" do
      assert_select "input[name=?]", "contract_instance[start_date]"
      assert_select "input[name=?]", "contract_instance[end_date]"

      assert_select "input[name=?]", "contract_instance[budget_limit]"
    end
  end
end
