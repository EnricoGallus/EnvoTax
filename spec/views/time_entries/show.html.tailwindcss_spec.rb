# frozen_string_literal: true

require "rails_helper"

RSpec.describe "time_entries/show", type: :view do
  before do
    assign(:time_entry, TimeEntry.create!(
                          name: "Name",
                          project: nil
                        ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
