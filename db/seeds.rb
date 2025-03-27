# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

User.find_or_create_by!(email: Rails.application.credentials.dig(:user, :email)) do |u|
  u.password = Rails.application.credentials.dig(:user, :password)
end

# TODO: make names translatable
cost_types = [
  { name: "Software" },
  { name: "Hardware" },
  { name: "Transportation" },
  { name: "Other" }
]

cost_types.each do |cost_type|
  CostType.find_or_create_by(name: cost_type[:name])
end

# TODO: make names translatable
categories = [
  { name: "Work" },
  { name: "Sponsorship" }
]

categories.each do |category|
  Category.find_or_create_by(name: category[:name])
end

# TODO: make names translatable
# TODO: future make tax entries country specific
IncomeTax.find_or_create_by(tax_type: "Income Tax 5%", tax_rate: 5.00)
IncomeTax.find_or_create_by(tax_type: "Income Tax 10.21%", tax_rate: 10.21)
IncomeTax.find_or_create_by(tax_type: "No Income Tax", tax_rate: 0.00)
