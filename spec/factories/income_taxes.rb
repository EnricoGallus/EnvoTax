# frozen_string_literal: true

FactoryBot.define do
  factory :income_tax do
    tax_type { "MyString" }
    tax_rate { "9.99" }
  end
end
