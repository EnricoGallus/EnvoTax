# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/show.html.erb", type: :view do
  before do
    assign(:client, create(:client))
    render
  end

  it "renders name" do
    expect(rendered).to match(/Name/)
  end

  it "renders currency" do
    expect(rendered).to match(/Currency/)
  end
end
