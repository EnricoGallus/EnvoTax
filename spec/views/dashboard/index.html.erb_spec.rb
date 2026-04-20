# frozen_string_literal: true

require "rails_helper"

RSpec.describe "dashboard/index.html.erb", type: :view do
  before { render }

  it "renders turbo frames for each dashboard section with correct src" do
    expect(rendered).to be_present

    sections = {
      today: today_dashboard_index_path,
      weekly: weekly_dashboard_index_path,
      monthly: monthly_dashboard_index_path,
      unbilled_time: unbilled_time_dashboard_index_path,
      outstanding_invoices: outstanding_invoices_dashboard_index_path
    }

    sections.each do |id, path|
      assert_select "turbo-frame##{id}[src='#{path}']", count: 1
    end
  end

  it "renders a translated loading title inside each frame as fallback" do
    %w[today weekly monthly unbilled_time outstanding_invoices].each do |id|
      exepected_title = "dashboard.loading.#{id}"
      assert_select "h2.card-title", text: I18n.t(exepected_title), count: 1
    end
  end
end
