# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    name { Faker::Name.unique.name }
    client
    budget_limit_cents { Faker::Number.between(from: 50_000, to: 10_000_000) }
    start_date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    end_date { Faker::Date.between(from: 1.day.from_now, to: 1.year.from_now) }
    status { :active }
  end
end
