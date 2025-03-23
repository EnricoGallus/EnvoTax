# frozen_string_literal: true

require "rails_helper"

RSpec.describe "income_taxes/edit", type: :view do
  let(:income_tax) do
    IncomeTax.create!(
      tax_type: "MyString",
      tax_rate: "9.99"
    )
  end

  before do
    assign(:income_tax, income_tax)
  end

  it "renders the edit income_tax form" do
    render

    assert_select "form[action=?][method=?]", income_tax_path(income_tax), "post" do
      assert_select "input[name=?]", "income_tax[tax_type]"

      assert_select "input[name=?]", "income_tax[tax_rate]"
    end
  end
end
