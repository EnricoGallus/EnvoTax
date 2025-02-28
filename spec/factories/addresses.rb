# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { "MyString" }
    city { "MyString" }
    zip { "MyString" }
    country { "MyString" }
  end
end
