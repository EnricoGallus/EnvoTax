# frozen_string_literal: true

json.extract! time_entry, :id, :date, :time_from, :time_to, :name, :project_id, :created_at, :updated_at
json.url time_entry_url(time_entry, format: :json)
