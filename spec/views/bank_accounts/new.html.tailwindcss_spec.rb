# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bank_accounts/new", type: :view do
  before do
    assign(:bank_account, BankAccount.new(
                            account_holder: "MyString",
                            bank_name: "MyString",
                            branch_code: "MyString",
                            account_number: "MyString",
                            accountable: nil
                          ))
  end

  it "renders new bank_account form" do
    render

    assert_select "form[action=?][method=?]", bank_accounts_path, "post" do
      assert_select "input[name=?]", "bank_account[account_holder]"

      assert_select "input[name=?]", "bank_account[bank_name]"

      assert_select "input[name=?]", "bank_account[branch_code]"

      assert_select "input[name=?]", "bank_account[account_number]"

      assert_select "input[name=?]", "bank_account[accountable_id]"
    end
  end
end
