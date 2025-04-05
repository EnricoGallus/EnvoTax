# frozen_string_literal: true

require "rails_helper"

RSpec.describe "time_entries/edit", type: :view do
  let(:time_entry) { create(:time_entry) }

  before do
    assign(:time_entry, time_entry)
  end

  it "renders the edit time_entry form" do
    render

    assert_select "form[action=?][method=?]", time_entry_path(time_entry), "post" do
      assert_select "input[name=?]", "time_entry[name]"

      assert_select "input[name=?]", "time_entry[time_from]"
    end
  end
end
