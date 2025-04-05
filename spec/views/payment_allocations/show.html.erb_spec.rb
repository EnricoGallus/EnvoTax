# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/show", type: :view do
  let(:payment_allocation) { create(:payment_allocation) }

  before do
    assign(:payment_allocation, payment_allocation)
    assign(:payment_statement, payment_allocation.payment_statement)
    render
  end

  it "renders attributes in <p>" do
    expect(rendered).to have_content(payment_allocation.amount.format)
    expect(rendered).to have_content(payment_allocation.income_tax.tax_type)
  end
end
