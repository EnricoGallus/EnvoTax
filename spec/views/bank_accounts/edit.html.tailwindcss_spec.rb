# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bank_accounts/edit", type: :view do
  let(:bank_account) do
    BankAccount.create!(
      account_holder: "MyString",
      bank_name: "MyString",
      branch_code: "MyString",
      account_number: "MyString",
      accountable: nil
    )
  end

  before do
    assign(:bank_account, bank_account)
  end

  it "renders the edit bank_account form" do
    render

    assert_select "form[action=?][method=?]", bank_account_path(bank_account), "post" do
      assert_select "input[name=?]", "bank_account[account_holder]"

      assert_select "input[name=?]", "bank_account[bank_name]"

      assert_select "input[name=?]", "bank_account[branch_code]"

      assert_select "input[name=?]", "bank_account[account_number]"

      assert_select "input[name=?]", "bank_account[accountable_id]"
    end
  end
end
