# frozen_string_literal: true

json.extract! expense, :id, :client_id, :project_id, :amount, :category, :description, :date, :created_at, :updated_at
json.url expense_url(expense, format: :json)
