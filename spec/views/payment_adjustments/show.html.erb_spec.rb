# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/show", type: :view do
  let(:payment_adjustment) { create(:payment_adjustment) }

  before do
    assign(:payment_adjustment, payment_adjustment)
    render
  end

  it "renders attributes in <p>" do
    expect(rendered).to match(payment_adjustment.amount.format)
    expect(rendered).to match(payment_adjustment.description)
    expect(rendered).to match(payment_adjustment.client.name)
    expect(rendered).to match(payment_adjustment.status)
  end
end
