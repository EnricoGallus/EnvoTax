# frozen_string_literal: true

json.array! @payment_adjustments, partial: "payment_adjustments/payment_adjustment", as: :payment_adjustment
