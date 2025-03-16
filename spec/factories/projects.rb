# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Name.name }
    client
    hourly_rate { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
