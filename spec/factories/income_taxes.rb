# frozen_string_literal: true

FactoryBot.define do
  factory :income_tax do
    tax_type { Faker::Name.unique.name }
    tax_rate { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
