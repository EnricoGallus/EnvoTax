# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    amount { Faker::Number.number(digits: 5) }
    cost_type
    category
    description { Faker::Name.name }
    date { Faker::Date.backward(days: 14) }

    # optional associations
    client { nil }
    invoice { nil }

    trait :with_client do
      client
    end

    trait :with_invoice do
      invoice
    end

    trait :with_client_and_invoice do
      with_client
      with_invoice
    end

    trait :with_receipt do
      receipt { Rack::Test::UploadedFile.new("spec/fixtures/files/receipt.pdf", "application/pdf") }
    end
  end
end
