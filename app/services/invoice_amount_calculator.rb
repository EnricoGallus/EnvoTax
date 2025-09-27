# frozen_string_literal: true

# used to calculate the total amount of an invoice
# uses strategy depending on the calculation mode setup on the client
class InvoiceAmountCalculator
  def initialize(invoice)
    @invoice = invoice
  end

  def call
    calculate_time_entries_total(@invoice.time_entries) + calculate_expenses_amount
  end

  def calculate_time_entries_total(time_entries)
    case @invoice.calculation_mode.to_sym
    when :item_based
      time_entries.sum(&:cost).to_money
    when :total_based
      Money.new(Rational(time_entries.sum(&:spent_time_in_seconds)) / 1.hour *
        @invoice.contract_instance.contract.client.hourly_rate)
    else
      raise ArgumentError, _(I18n.t("invoices.unsupported_calculation_mode", mode: @invoice.calculation_mode))
    end
  end

  private

  def calculate_expenses_amount
    @invoice.expenses.debit.sum(:amount_cents).to_money -
      @invoice.expenses.credit.sum(:amount_cents).to_money
  end
end
