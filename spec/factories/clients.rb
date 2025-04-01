# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    hourly_rate_cents { Faker::Number.number(digits: 5) }
  end
end
