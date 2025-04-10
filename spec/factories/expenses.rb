# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    amount { Faker::Number.number(digits: 5) }
    cost_type
    contract_instance
    description { Faker::Name.name }
    date { Faker::Date.backward(days: 14) }
    transaction_type { :credit }

    # optional associations
    invoice { nil }

    trait :with_invoice do
      invoice
    end

    trait :with_receipt do
      receipt { Rack::Test::UploadedFile.new("spec/fixtures/files/receipt.pdf", "application/pdf") }
    end
  end
end
