# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/show", type: :view do
  let(:payment_statement) { create(:payment_statement) }

  before do
    assign(:payment_statement, payment_statement)
    render
  end

  it "renders attributes in <p>" do
    expect(rendered).to have_content(payment_statement.client.name)
    expect(rendered).to have_content(payment_statement.amount.format)
    expect(rendered).to have_content(payment_statement.received_on)
    expect(rendered).to have_content(payment_statement.status)
  end
end
