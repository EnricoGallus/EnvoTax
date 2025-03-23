# frozen_string_literal: true

require "rails_helper"

RSpec.describe "income_taxes/new", type: :view do
  before do
    assign(:income_tax, IncomeTax.new(
                          tax_type: "MyString",
                          tax_rate: "9.99"
                        ))
  end

  it "renders new income_tax form" do
    render

    assert_select "form[action=?][method=?]", income_taxes_path, "post" do
      assert_select "input[name=?]", "income_tax[tax_type]"

      assert_select "input[name=?]", "income_tax[tax_rate]"
    end
  end
end
