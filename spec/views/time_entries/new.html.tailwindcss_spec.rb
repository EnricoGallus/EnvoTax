# frozen_string_literal: true

require "rails_helper"

RSpec.describe "time_entries/new", type: :view do
  before do
    assign(:time_entry, TimeEntry.new(
                          name: "MyString",
                          project: nil
                        ))
  end

  it "renders new time_entry form" do
    render

    assert_select "form[action=?][method=?]", time_entries_path, "post" do
      assert_select "input[name=?]", "time_entry[name]"

      assert_select "input[name=?]", "time_entry[project_id]"
    end
  end
end
