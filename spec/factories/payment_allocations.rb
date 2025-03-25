# frozen_string_literal: true

FactoryBot.define do
  factory :payment_allocation do
    amount { Faker::Number.number(digits: 5) }
    income_tax
    payment_statement
    reference { association invoice }

    trait :for_payment_adjustment do
      reference { association payment_adjustment }
    end
  end
end
