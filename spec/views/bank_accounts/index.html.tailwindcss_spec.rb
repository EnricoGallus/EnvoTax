# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bank_accounts/index", type: :view do
  before do
    assign(:bank_accounts, [
             BankAccount.create!(
               account_holder: "Account Holder",
               bank_name: "Bank Name",
               branch_code: "Branch Code",
               account_number: "Account Number",
               accountable: nil
             ),
             BankAccount.create!(
               account_holder: "Account Holder",
               bank_name: "Bank Name",
               branch_code: "Branch Code",
               account_number: "Account Number",
               accountable: nil
             )
           ])
  end

  it "renders a list of bank_accounts" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Account Holder"), count: 2
    assert_select cell_selector, text: Regexp.new("Bank Name"), count: 2
    assert_select cell_selector, text: Regexp.new("Branch Code"), count: 2
    assert_select cell_selector, text: Regexp.new("Account Number"), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
