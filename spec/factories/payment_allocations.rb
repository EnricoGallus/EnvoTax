# frozen_string_literal: true

FactoryBot.define do
  factory :payment_allocation do
    income_tax
    payment_statement
    reference factory: %i[invoice]

    amount do
      Money.new(
        Faker::Number.between(
          from: 1,
          to: payment_statement&.unallocated_amount&.cents || payment_statement&.amount_cents || 1000
        )
      )
    end

    trait :for_payment_adjustment do
      reference factory: %i[payment_adjustment]
    end
  end
end
