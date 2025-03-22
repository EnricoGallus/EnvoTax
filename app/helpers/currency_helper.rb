# helps in formatting the currency correctly
module CurrencyHelper
  def format_currency(amount)
    number_to_currency(amount, unit: "円", precision: 0, format: "%n%u")
  end
end
