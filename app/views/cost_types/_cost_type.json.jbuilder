# frozen_string_literal: true

json.extract! cost_type, :id, :name, :created_at, :updated_at
json.url cost_type_url(cost_type, format: :json)
