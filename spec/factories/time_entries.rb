# frozen_string_literal: true

FactoryBot.define do
  factory :time_entry do
    date { "2025-03-21" }
    time_from { "2025-03-21 14:32:53" }
    time_to { "2025-03-21 14:32:53" }
    name { "MyString" }
    project { nil }
  end
end
