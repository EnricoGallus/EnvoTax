# frozen_string_literal: true

require "rails_helper"

RSpec.describe "income_taxes/show", type: :view do
  before do
    assign(:income_tax, IncomeTax.create!(
                          tax_type: "Tax Type",
                          tax_rate: "9.99"
                        ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Tax Type/)
    expect(rendered).to match(/9.99/)
  end
end
