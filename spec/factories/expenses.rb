# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    amount { Faker::Number.number(digits: 5) }
    cost_type
    contract_instance
    description { Faker::Name.name }
    date { Faker::Date.backward(days: 14) }
    transaction_type { :debit }

    # optional associations
    invoice { nil }

    trait :with_invoice do
      invoice
    end

    trait :with_receipt do
      after(:build) do |invoice|
        invoice.receipt.attach(
          io: File.open(Rails.root.join("spec/fixtures/files/receipt.txt")),
          filename: "receipt.txt",
          content_type: "text/plain"
        )
      end
    end
  end
end
