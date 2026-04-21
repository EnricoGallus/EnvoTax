# frozen_string_literal: true

require "rails_helper"

RSpec.describe "dashboard/outstanding_invoices.html.erb", type: :view do
  it "formats the total due as yen" do
    invoice = create(:invoice, total_amount_cents: 2500)

    assign(:invoices, Invoice.where(id: invoice.id))
    assign(:total_due, invoice.total_amount)

    render

    expect(rendered).to include(Money.new(2500, "JPY").format)
    expect(rendered).not_to include("$2,500")
  end
end
