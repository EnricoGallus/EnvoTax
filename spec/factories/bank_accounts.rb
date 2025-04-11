# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    account_holder { Faker::Name.name }
    bank_name { Faker::Name.name }
    branch_code { Faker::Number.number(digits: 3) }
    account_number { Faker::Number.number(digits: 7) }
    account_type { :ordinary }

    for_user

    trait :for_user do
      factory accountable: %i[user]
    end
  end
end
