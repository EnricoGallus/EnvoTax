# frozen_string_literal: true

FactoryBot.define do
  factory :payment_statement do
    client
    user
    amount { Faker::Number.number(digits: 5) }
    received_on { Faker::Date.between(from: 3.months.ago, to: Time.zone.now) }
    status { :pending }
  end
end
