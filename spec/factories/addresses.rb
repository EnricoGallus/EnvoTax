# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture { Faker::Address.state }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    building { Faker::Address.secondary_address }
    country { :japan }

    for_client

    trait :for_client do
      addressable factory: %i[client]
    end

    trait :for_user do
      addressable factory: %i[user]
    end
  end
end
