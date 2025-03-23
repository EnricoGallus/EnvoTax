json.extract! payment_allocation, :id, :amount, :tax_id, :payment_statement_id, :reference_id, :reference_type, :created_at, :updated_at
json.url payment_allocation_url(payment_allocation, format: :json)
