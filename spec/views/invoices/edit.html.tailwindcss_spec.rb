# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/edit", type: :view do
  let(:invoice) do
    Invoice.create!(
      client: nil,
      user: nil,
      status: 1
    )
  end

  before do
    assign(:invoice, invoice)
  end

  it "renders the edit invoice form" do
    render

    assert_select "form[action=?][method=?]", invoice_path(invoice), "post" do
      assert_select "input[name=?]", "invoice[client_id]"

      assert_select "input[name=?]", "invoice[user_id]"

      assert_select "input[name=?]", "invoice[status]"
    end
  end
end
