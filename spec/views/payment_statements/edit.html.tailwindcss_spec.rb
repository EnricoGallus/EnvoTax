# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/edit", type: :view do
  let(:payment_statement) do
    PaymentStatement.create!(
      client: nil,
      user: nil,
      amount: "9.99",
      status: "MyString"
    )
  end

  before do
    assign(:payment_statement, payment_statement)
  end

  it "renders the edit payment_statement form" do
    render

    assert_select "form[action=?][method=?]", payment_statement_path(payment_statement), "post" do
      assert_select "input[name=?]", "payment_statement[client_id]"

      assert_select "input[name=?]", "payment_statement[user_id]"

      assert_select "input[name=?]", "payment_statement[amount]"

      assert_select "input[name=?]", "payment_statement[status]"
    end
  end
end
