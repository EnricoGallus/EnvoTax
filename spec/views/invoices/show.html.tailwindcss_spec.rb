# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/show", type: :view do
  before do
    assign(:invoice, Invoice.create!(
                       client: nil,
                       user: nil,
                       status: 2
                     ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
