# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/new", type: :view do
  before do
    assign(:payment_statement, PaymentStatement.new)
    render
  end

  it "renders new payment_statement form" do
    assert_select "form[action=?][method=?]", payment_statements_path, "post" do
      assert_select "select[name=?]", "payment_statement[client_id]"

      assert_select "input[name=?]", "payment_statement[amount]"
    end
  end
end
