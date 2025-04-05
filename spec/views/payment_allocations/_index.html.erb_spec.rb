# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_allocations/index", type: :view do
  let(:payment_statement) { create(:payment_statement) }
  let(:payment_allocations) { create_list(:payment_allocation, 2, payment_statement: payment_statement) }

  before do
    assign(:payment_statement, payment_statement)
    assign(:payment_allocations, payment_allocations)
    render partial: "payment_allocations/index", locals: { payment_statement: payment_statement }
  end

  it "renders a list of payment_adjustments" do
    assert_select "#payment_allocations" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_details(element, payment_allocations[index]) }
      end
    end
  end

  private

  def assert_details(element, allocation)
    assert_select element, "td", text: allocation.amount.format, count: 1
    assert_select element, "td", text: allocation.income_tax.tax_type, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
