# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    name { Faker::Name.unique.name }
    client
    status { :active }
  end
end
