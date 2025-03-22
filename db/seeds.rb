# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# TODO: move email and password to credentials
user = User.new(email: "test@test.com", password: "hugahuga")
user.save!

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
