# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { "MyString" }
    currency { "MyString" }
    address { nil }
  end
end
