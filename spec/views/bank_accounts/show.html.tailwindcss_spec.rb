# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bank_accounts/show", type: :view do
  before do
    assign(:bank_account, BankAccount.create!(
                            account_holder: "Account Holder",
                            bank_name: "Bank Name",
                            branch_code: "Branch Code",
                            account_number: "Account Number",
                            accountable: nil
                          ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Account Holder/)
    expect(rendered).to match(/Bank Name/)
    expect(rendered).to match(/Branch Code/)
    expect(rendered).to match(/Account Number/)
    expect(rendered).to match(//)
  end
end
