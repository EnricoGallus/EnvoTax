# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/show.html.erb", type: :view do
  before do
    assign(:client, create(:client))
    render
  end

  it "renders name" do
    expect(rendered).to match(I18n.t("activerecord.attributes.client.name"))
  end

  it "renders hourly rate" do
    expect(rendered).to match(I18n.t("activerecord.attributes.client.hourly_rate"))
  end
end
