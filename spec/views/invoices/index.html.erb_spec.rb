# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/index", type: :view do
  let(:user) { create(:user) }
  let(:invoices) { create_list(:invoice, 2, user: user) }

  before do
    assign(:invoices, invoices)
    assign(:q, Invoice.ransack)
    enable_pundit(view, user)
    render
  end

  it "renders a list of invoices" do
    assert_select "#invoices" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_details(element, invoices[index]) }
      end
    end
  end

  private

  def assert_details(element, invoice)
    assert_select element, "td", text: invoice.contract_instance.name, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Preview/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
