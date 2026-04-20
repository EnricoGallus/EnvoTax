# frozen_string_literal: true

require "rails_helper"

RSpec.describe Dashboard::LazyComponent, type: :component do
  let(:id) { "today" }
  let(:path) { "/dashboard/today" }

  it "renders a turbo-frame with the given id and src" do
    result = render_inline(described_class.new(id:, path:))

    expect(result).to have_css("turbo-frame##{id}[src='#{path}']")
  end

  it "renders a translated loading title as fallback" do
    result = render_inline(described_class.new(id:, path:))

    expected_title = "dashboard.loading.#{id}"
    expect(result).to have_css("h2.card-title", text: I18n.t(expected_title))
  end

  it "includes skeleton placeholders in the fallback content" do
    result = render_inline(described_class.new(id:, path:))

    expect(result).to have_css(".card .card-body .skeleton", minimum: 1)
  end
end
