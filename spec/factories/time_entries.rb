# frozen_string_literal: true

FactoryBot.define do
  factory :time_entry do
    name { Faker::Name.name }
    date { Faker::Date.between(from: 1.month.ago, to: Time.zone.now) }
    project

    sequence(:time_from) do |n|
      hour = (8 + (n * 2)) % 24
      Time.zone.parse("#{hour}:00")
    end

    sequence(:time_to) do |n|
      hour = (9 + (n * 2)) % 24
      Time.zone.parse("#{hour}:00")
    end

    trait :with_invoice do
      invoice
    end

    trait :random do
      time_from { Faker::Time.between(from: DateTime.parse("8:00"), to: DateTime.parse("16:00")) }
      time_to { |e| Faker::Time.between(from: e.time_from, to: DateTime.parse("18:00")) }
    end

    trait :with_duration do
      transient do
        hours { 2 }
        minutes { 0 }
        start_hour { 10 }
      end

      time_from { Time.zone.local(date.year, date.month, date.day, start_hour, 0, 0) }
      time_to { time_from + hours.hours + minutes.minutes }
    end
  end
end
