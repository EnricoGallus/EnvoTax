# frozen_string_literal: true

json.array! @payment_statements, partial: "payment_statements/payment_statement", as: :payment_statement
