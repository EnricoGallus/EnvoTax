# frozen_string_literal: true

FactoryBot.define do
  factory :payment_adjustment do
    amount { Faker::Number.number(digits: 5) }
    date { Faker::Date.between(from: 3.months.ago, to: Time.zone.now) }
    description { Faker::Lorem.sentence(word_count: 3) }
    status { :pending }
    client
    user

    trait :partially_paid do
      status { :partially_paid }
    end

    trait :paid do
      status { :paid }
    end

    trait :canceled do
      status { :canceled }
    end
  end
end
