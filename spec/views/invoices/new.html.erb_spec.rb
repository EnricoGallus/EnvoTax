# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/new", type: :view do
  before do
    assign(:invoice, Invoice.new)
    render
  end

  it "renders new invoice form" do
    assert_select "form[action=?][method=?]", invoices_path, "post" do
      assert_select "select[name=?]", "invoice[contract_id]"
      assert_select "input[name=?]", "invoice[invoice_date]"

      assert_select "input[name=?]", "invoice[start_date]"
      assert_select "input[name=?]", "invoice[end_date]"
    end
  end
end
