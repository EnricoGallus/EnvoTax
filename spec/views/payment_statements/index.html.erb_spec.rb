# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/index", type: :view do
  let(:payment_statements) { create_list(:payment_statement, 2) }

  before do
    assign(:payment_statements, payment_statements)
    assign(:q, PaymentStatement.ransack)
    render
  end

  it "renders a list of payment statements" do
    assert_select "#payment_statements" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_details(element, payment_statements[index]) }
      end
    end
  end

  private

  def assert_details(element, payment_statement)
    assert_select element, "td", text: payment_statement.amount.format, count: 1
    assert_select element, "td", text: payment_statement.client.name, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
