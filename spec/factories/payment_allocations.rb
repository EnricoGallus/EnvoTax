# frozen_string_literal: true

FactoryBot.define do
  factory :payment_allocation do
    amount { "9.99" }
    tax { nil }
    payment_statement { nil }
    reference { nil }
  end
end
