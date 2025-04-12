# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    name { Faker::Name.unique.name }
    status { :active }

    client
    user
  end
end
