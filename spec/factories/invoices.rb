# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    user
    contract
    invoice_date { Faker::Date.backward(days: 30) }
    start_date { Faker::Date.backward(days: 60) }
    end_date { Faker::Date.backward(days: 30) }
    status { :draft }
  end
end
