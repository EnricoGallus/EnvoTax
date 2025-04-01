# frozen_string_literal: true

FactoryBot.define do
  factory :contract_instance do
    contract
    budget_limit_cents { Faker::Number.between(from: 50_000, to: 10_000_000) }
    start_date { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
    end_date { Faker::Date.between(from: 1.day.from_now, to: 1.year.from_now) }
  end
end
