# frozen_string_literal: true

require "rails_helper"

RSpec.describe "income_taxes/index", type: :view do
  let(:income_taxes) { create_list(:income_tax, 2) }

  before do
    assign(:income_taxes, income_taxes)
    assign(:q, IncomeTax.ransack)
    render
  end

  it "renders a list of income_taxes" do
    assert_select "#income_taxes" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_details(element, income_taxes[index]) }
      end
    end
  end

  private

  def assert_details(element, income_tax)
    assert_select element, "td", text: income_tax.tax_type, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
