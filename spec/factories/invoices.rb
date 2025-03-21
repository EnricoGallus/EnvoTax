# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    client { nil }
    user { nil }
    start_date { "2025-03-21" }
    end_date { "2025-03-21" }
    status { 1 }
    invoice_date { "2025-03-21" }
  end
end
