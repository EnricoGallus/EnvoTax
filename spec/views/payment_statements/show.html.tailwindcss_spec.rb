# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/show", type: :view do
  before do
    assign(:payment_statement, PaymentStatement.create!(
                                 client: nil,
                                 user: nil,
                                 amount: "9.99",
                                 status: "Status"
                               ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Status/)
  end
end
