# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/show", type: :view do
  let(:contract) { create(:contract) }

  before do
    q_mock = double(Ransack, result: contract.contract_instances)
    allow(view).to receive(:sort_link).and_return("Sort Link")
    assign(:contract, contract)
    assign(:q, q_mock)
    assign(:contract_instances, create_list(:contract_instance, 2, contract: contract))
  end

  it "renders contract and instances" do
    render

    expect(rendered).to have_css("h1", text: "Showing contract")

    expect(rendered).to have_content(contract.name)

    expect(rendered).to have_link("Edit", href: edit_contract_path(contract))
    expect(rendered).to have_link("Back", href: contracts_path)
    expect(rendered).to have_button("Delete")

    expect(rendered).to have_css("h1", text: "Contract Instances")
    expect(rendered).to have_link("New Contract Instance")
    expect(rendered).to have_css("table tbody tr", count: 2)
  end
end
