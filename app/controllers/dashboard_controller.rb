# frozen_string_literal: true

# default controller for the root path
class DashboardController < ApplicationController
  def index; end

  def today
    @entries = TimeEntry.where(date: Time.zone.today).order(:time_from)
  end

  def weekly
    range = Date.current.all_month

    @weekly_hours = TimeEntry
                    .where(date: range)
                    .group_by_week(:date, format: "%W")
                    .sum(:spent_time_in_seconds)

    @weekly_income = TimeEntry
                     .where(date: range)
                     .group_by_week(:date, format: "%W")
                     .sum(:cost_cents)
  end

  def monthly
    range = Date.current.all_year

    @monthly_hours = TimeEntry
                     .where(date: range)
                     .group_by_month(:date, format: "%b")
                     .sum(:spent_time_in_seconds)

    @monthly_income = TimeEntry
                      .where(date: range)
                      .group_by_month(:date, format: "%b")
                      .sum(:cost_cents)
  end

  def unbilled_time
    @entries = TimeEntry.where(invoice: nil)
    @total_hours = @entries.sum(:spent_time_in_seconds)
    @total_value = @entries.sum(&:cost)
  end

  def outstanding_invoices
    @invoices = Invoice.not_paid.order(:invoice_date)
    @total_due = @invoices.sum(&:total_amount)
  end
end
