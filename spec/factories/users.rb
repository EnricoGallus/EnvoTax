# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }

    factory :valid_user do
      after(:build) do |user|
        user.address ||= build(:address, addressable: user)
        user.bank_account ||= build(:bank_account, accountable: user)
      end
    end
  end
end
