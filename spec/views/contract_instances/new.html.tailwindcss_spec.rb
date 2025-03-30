# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contract_instances/new", type: :view do
  before do
    assign(:contract_instance, ContractInstance.new(
                                 contract: nil,
                                 budget_limit_cents: 1,
                                 budget_limit_currency: "MyString"
                               ))
  end

  it "renders new contract_instance form" do
    render

    assert_select "form[action=?][method=?]", contract_instances_path, "post" do
      assert_select "input[name=?]", "contract_instance[contract_id]"

      assert_select "input[name=?]", "contract_instance[budget_limit_cents]"

      assert_select "input[name=?]", "contract_instance[budget_limit_currency]"
    end
  end
end
