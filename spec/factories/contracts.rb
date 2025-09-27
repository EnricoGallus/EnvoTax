# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    name { Faker::Name.unique.name }
    status { :active }

    client factory: %i[valid_client]
    user factory: %i[valid_user]
  end
end
