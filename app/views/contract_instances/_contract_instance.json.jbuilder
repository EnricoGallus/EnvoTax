json.extract! contract_instance, :id, :contract_id, :start_date, :end_date, :budget_limit_cents, :budget_limit_currency, :created_at, :updated_at
json.url contract_instance_url(contract_instance, format: :json)
