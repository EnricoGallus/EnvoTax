# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/show", type: :view do
  before do
    assign(:payment_adjustment, PaymentAdjustment.create!(
                                  client: nil,
                                  user: nil,
                                  amount: "9.99",
                                  description: "Description",
                                  status: 2
                                ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/2/)
  end
end
