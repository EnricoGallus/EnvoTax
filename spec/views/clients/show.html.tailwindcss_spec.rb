# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/show" do
  before do
    assign(:client, Client.create!(
                      name: "Name",
                      currency: "Currency",
                      address: nil
                    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(//)
  end
end
