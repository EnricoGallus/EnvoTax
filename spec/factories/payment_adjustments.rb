# frozen_string_literal: true

FactoryBot.define do
  factory :payment_adjustment do
    client { nil }
    user { nil }
    amount { "9.99" }
    description { "MyString" }
    date { "2025-03-23" }
    status { 1 }
  end
end
