# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    hourly_rate { Faker::Number.number(digits: 5) }
    address factory: %i[address]
  end
end
