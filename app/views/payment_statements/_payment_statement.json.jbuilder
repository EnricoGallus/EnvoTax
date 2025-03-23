# frozen_string_literal: true

json.extract! payment_statement, :id, :client_id, :user_id, :amount, :received_on, :status, :created_at, :updated_at
json.url payment_statement_url(payment_statement, format: :json)
