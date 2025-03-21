# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/new", type: :view do
  before do
    assign(:invoice, Invoice.new(
                       client: nil,
                       user: nil,
                       status: 1
                     ))
  end

  it "renders new invoice form" do
    render

    assert_select "form[action=?][method=?]", invoices_path, "post" do
      assert_select "input[name=?]", "invoice[client_id]"

      assert_select "input[name=?]", "invoice[user_id]"

      assert_select "input[name=?]", "invoice[status]"
    end
  end
end
