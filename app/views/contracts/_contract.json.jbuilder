json.extract! contract, :id, :name, :client_id, :budget_limit_cents, :budget_limit_currency, :start_date, :end_date, :status, :created_at, :updated_at
json.url contract_url(contract, format: :json)
