# frozen_string_literal: true

FactoryBot.define do
  factory :time_entry do
    name { Faker::Name.name }
    date { Faker::Date.between(from: 1.month.ago, to: Time.zone.now) }
    time_from { Faker::Time.between(from: DateTime.now - 4, to: DateTime.now - 2) }
    time_to { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    project

    trait :with_invoice do
      invoice
    end
  end
end
