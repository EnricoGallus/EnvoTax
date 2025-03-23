# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/new", type: :view do
  before do
    assign(:payment_statement, PaymentStatement.new(
                                 client: nil,
                                 user: nil,
                                 amount: "9.99",
                                 status: "MyString"
                               ))
  end

  it "renders new payment_statement form" do
    render

    assert_select "form[action=?][method=?]", payment_statements_path, "post" do
      assert_select "input[name=?]", "payment_statement[client_id]"

      assert_select "input[name=?]", "payment_statement[user_id]"

      assert_select "input[name=?]", "payment_statement[amount]"

      assert_select "input[name=?]", "payment_statement[status]"
    end
  end
end
