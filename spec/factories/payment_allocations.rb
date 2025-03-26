# frozen_string_literal: true

FactoryBot.define do
  factory :payment_allocation do
    amount { Faker::Number.number(digits: 5) }
    income_tax
    payment_statement
    reference factory: %i[invoice]

    trait :for_payment_adjustment do
      reference factory: %i[payment_adjustment]
    end
  end
end
