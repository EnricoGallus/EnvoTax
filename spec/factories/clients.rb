# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    currency { :yen }
    address factory: %i[address]
  end
end
