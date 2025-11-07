# frozen_string_literal: true

require "rails_helper"

RSpec.describe "time_entries/index", type: :view do
  let(:project) { create(:project) }

  before do
    assign(:time_entries, [
             create(:time_entry, slot_index: 0, project: project, name: "Task 1"),
             create(:time_entry, slot_index: 1, project: project, name: "Task 2"),
             create(:time_entry, :tomorrow, project: project, name: "Task 3")
           ])

    assign(:q, TimeEntry.ransack)
    assign(:pagy, Pagy.new(count: 3, page: 1))
  end

  context "when renders a list of time_entries grouped by date" do
    before do
      render
    end

    it "has header" do
      assert_select "h1", text: I18n.t("time_entry.index.title")
    end

    it "has new link" do
      assert_select "a[href=?]", new_time_entry_path
    end

    it "has one table per date" do
      assert_select "h2", count: 2
      assert_select "table", count: 2
    end

    it "displays all time entries" do
      assert_select "td", text: "Task 1"
      assert_select "td", text: "Task 2"
      assert_select "td", text: "Task 3"
    end
  end

  context "when there are no time entries" do
    before do
      assign(:time_entries, [])
      assign(:q, TimeEntry.ransack)
    end

    it "displays a message indicating no entries were found" do
      render
      assert_select "p", text: I18n.t("expense.index.none_found")
    end
  end
end
