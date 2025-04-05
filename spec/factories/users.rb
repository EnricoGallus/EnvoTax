# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
  end

  trait :with_address do
    after(:build) do |user|
      user.address ||= build(:address, addressable: user)
    end
  end

  trait :with_bank_account do
    after(:build) do |user|
      user.bank_account ||= build(:bank_account, accountable: user)
    end
  end

  trait :with_all_associations do
    with_address
    with_bank_account
  end
end
