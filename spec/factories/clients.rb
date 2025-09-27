# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    hourly_rate_cents { Faker::Number.number(digits: 5) }
    calculation_mode { :item_based }

    user

    factory :valid_client do
      after(:build) do |client|
        client.address ||= build(:address, addressable: client)
      end
    end
  end
end
