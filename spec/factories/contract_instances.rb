# frozen_string_literal: true

FactoryBot.define do
  factory :contract_instance do
    contract { nil }
    start_date { "2025-03-30" }
    end_date { "2025-03-30" }
    budget_limit_cents { 1 }
    budget_limit_currency { "MyString" }
  end
end
