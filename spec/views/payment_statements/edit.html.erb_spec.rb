# frozen_string_literal: true

require "rails_helper"

RSpec.describe "payment_statements/edit", type: :view do
  let(:payment_statement) { create(:payment_statement) }

  before do
    assign(:payment_statement, payment_statement)
    render
  end

  it "renders the edit payment_statement form" do
    assert_select "form[action=?][method=?]", payment_statement_path(payment_statement), "post" do
      assert_select "select[name=?]", "payment_statement[client_id]"

      assert_select "input[name=?]", "payment_statement[amount]"
    end
  end
end
