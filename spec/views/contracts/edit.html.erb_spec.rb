# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/edit", type: :view do
  let(:contract) { create(:contract) }

  before do
    assign(:contract, contract)
  end

  it "renders the edit contract form" do
    render

    assert_select "form[action=?][method=?]", contract_path(contract), "post" do
      assert_select "input[name=?]", "contract[name]"

      assert_select "select[name=?]", "contract[client_id]"
    end
  end
end
