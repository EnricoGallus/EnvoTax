# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    name { "MyString" }
    client { nil }
    budget_limit_cents { 1 }
    budget_limit_currency { "MyString" }
    start_date { "2025-03-29" }
    end_date { "2025-03-29" }
    status { 1 }
  end
end
