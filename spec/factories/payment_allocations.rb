# frozen_string_literal: true

FactoryBot.define do
  factory :payment_allocation do
    amount { Faker::Number.number(digits: 5) }
    income_tax
    payment_statement
    reference { create(:invoice) }

    trait :for_payment_adjustment do
      reference { create(:payment_adjustment) }
    end
  end
end
