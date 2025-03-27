# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    account_holder { "MyString" }
    bank_name { "MyString" }
    branch_code { "MyString" }
    account_number { "MyString" }
    accountable { nil }
  end
end
