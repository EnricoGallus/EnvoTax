# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/new", type: :view do
  before do
    assign(:contract, Contract.new(
                        name: "MyString",
                        client: nil,
                        budget_limit_cents: 1,
                        budget_limit_currency: "MyString",
                        status: 1
                      ))
  end

  it "renders new contract form" do
    render

    assert_select "form[action=?][method=?]", contracts_path, "post" do
      assert_select "input[name=?]", "contract[name]"

      assert_select "input[name=?]", "contract[client_id]"

      assert_select "input[name=?]", "contract[budget_limit_cents]"

      assert_select "input[name=?]", "contract[budget_limit_currency]"

      assert_select "input[name=?]", "contract[status]"
    end
  end
end
