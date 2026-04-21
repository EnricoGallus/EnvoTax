# frozen_string_literal: true

require "rails_helper"

RSpec.describe "dashboard/unbilled_time.html.erb", type: :view do
  it "formats the total value as yen" do
    client = create(:client, hourly_rate_cents: 1200)
    project = create(:project, client: client)
    entries = [
      create(:time_entry, :with_duration, project: project, hours: 1, invoice: nil)
    ]

    assign(:entries, TimeEntry.where(id: entries.map(&:id)))
    assign(:total_hours, entries.sum(&:spent_time_in_seconds))
    assign(:total_value, entries.sum(&:cost))

    render

    expect(rendered).to include(Money.new(1200, "JPY").format)
    expect(rendered).not_to include("$1,200")
  end
end
