# frozen_string_literal: true

FactoryBot.define do
  factory :cost_type do
    name { Faker::Name.unique.name }

    user
  end
end
