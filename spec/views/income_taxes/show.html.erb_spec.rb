# frozen_string_literal: true

require "rails_helper"

RSpec.describe "income_taxes/show", type: :view do
  let(:income_tax) { create(:income_tax) }

  before do
    assign(:income_tax, income_tax)
    render
  end

  it "renders attributes in <p>" do
    expect(rendered).to match(I18n.t("activerecord.attributes.income_tax.tax_type"))
    expect(rendered).to match(income_tax.tax_type)
  end
end
