# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture { Faker::Address.state }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    building { Faker::Address.secondary_address }
    country { :japan }
  end
end
