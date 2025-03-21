json.extract! invoice, :id, :client_id, :user_id, :start_date, :end_date, :status, :invoice_date, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
