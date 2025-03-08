# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/show.html.erb", type: :view do
  before do
    assign(:client, create(:client))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(//)
  end
end
