# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/index", type: :view do
  before do
    assign(:contracts, create_list(:contract, 2))
    assign(:q, Contract.ransack)
  end

  it "renders a list of contracts" do
    render

    # Test page title and header
    expect(rendered).to have_css("h1", text: "Contracts")

    # Test new contract button
    expect(rendered).to have_link("New Contract", href: new_contract_path)

    # Test table headers
    expect(rendered).to have_css("table thead th", count: 4)
    expect(rendered).to have_css("table thead th", text: "Actions")

    # Test contract data
    expect(rendered).to have_css("table tbody tr", count: 2)
  end
end
