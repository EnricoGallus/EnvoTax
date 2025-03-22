# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    client { nil }
    project { nil }
    amount { "9.99" }
    cost_type
    description { "MyText" }
    date { "2025-03-21" }
  end
end
