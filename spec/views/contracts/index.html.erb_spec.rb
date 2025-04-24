# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contracts/index", type: :view do
  let(:user) { create(:user) }

  before do
    assign(:contracts, create_list(:contract, 2, user: user))
    assign(:q, Contract.ransack)
    enable_pundit(view, user)
    render
  end

  it "renders a list of contracts" do
    # Test page title and header
    expect(rendered).to have_css("h1", text: "Contracts")

    # Test new contract button
    expect(rendered).to have_link("New Contract", href: new_contract_path)

    # Test table headers
    expect(rendered).to have_css("table thead th", count: 5)
    expect(rendered).to have_css("table thead th", text: "Actions")

    # Test contract data
    expect(rendered).to have_css("table tbody tr", count: 2)
  end
end
