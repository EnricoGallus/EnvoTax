# frozen_string_literal: true

json.extract! project, :id, :name, :client_id, :hourly_rate, :created_at, :updated_at
json.url project_url(project, format: :json)
