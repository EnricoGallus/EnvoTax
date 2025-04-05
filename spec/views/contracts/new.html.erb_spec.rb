# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/new", type: :view do
  before do
    assign(:contract, Contract.new)
  end

  it "renders new contract form" do
    render

    assert_select "form[action=?][method=?]", contracts_path, "post" do
      assert_select "input[name=?]", "contract[name]"

      assert_select "select[name=?]", "contract[client_id]"
    end
  end
end
