# frozen_string_literal: true

json.extract! payment_adjustment, :id, :client_id, :user_id, :amount, :description, :date, :status, :created_at,
              :updated_at
json.url payment_adjustment_url(payment_adjustment, format: :json)
