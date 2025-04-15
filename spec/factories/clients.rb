# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    hourly_rate_cents { Faker::Number.number(digits: 5) }
    calculation_mode { :item_based }

    user

    trait :with_address do
      after(:build) do |client|
        client.build_address(
          postal_code: "123-4567",
          prefecture: "Tokyo",
          city: "Shibuya",
          street: "Example Street",
          country: "japan"
        )
      end
    end
  end
end
