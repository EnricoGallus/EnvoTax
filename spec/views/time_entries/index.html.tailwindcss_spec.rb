# frozen_string_literal: true

require "rails_helper"

RSpec.describe "time_entries/index", type: :view do
  before do
    assign(:time_entries, [
             TimeEntry.create!(
               name: "Name",
               project: nil
             ),
             TimeEntry.create!(
               name: "Name",
               project: nil
             )
           ])
  end

  it "renders a list of time_entries" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Name"), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
