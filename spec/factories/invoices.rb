# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    invoice_date { Faker::Date.backward(days: 30) }
    start_date { Faker::Date.backward(days: 60) }
    end_date { Faker::Date.backward(days: 30) }
    status { :draft }
    calculation_mode { :total_based }

    user
    contract_instance
    client

    trait :approved do
      status { :approved }
    end
  end
end
