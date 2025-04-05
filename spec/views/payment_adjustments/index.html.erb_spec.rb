# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_adjustments/index", type: :view do
  let(:payment_adjustments) { create_list(:payment_adjustment, 2) }

  before do
    assign(:payment_adjustments, payment_adjustments)
    assign(:q, PaymentAdjustment.ransack)
    render
  end

  it "renders a list of payment_adjustments" do
    assert_select "#payment_adjustments" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_details(element, payment_adjustments[index]) }
      end
    end
  end

  private

  def assert_details(element, adjustment)
    assert_select element, "td", text: adjustment.amount.format, count: 1
    assert_select element, "td", text: adjustment.client.name, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
