# frozen_string_literal: true

FactoryBot.define do
  factory :payment_statement do
    client { nil }
    user { nil }
    amount { "9.99" }
    received_on { "2025-03-23" }
    status { "MyString" }
  end
end
