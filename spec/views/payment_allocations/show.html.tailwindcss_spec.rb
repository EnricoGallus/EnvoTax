# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/show", type: :view do
  before do
    assign(:payment_allocation, PaymentAllocation.create!(
                                  amount: "9.99",
                                  tax: nil,
                                  payment_statement: nil,
                                  reference: nil
                                ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
