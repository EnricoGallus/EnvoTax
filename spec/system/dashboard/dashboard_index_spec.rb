# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Dashboard", :js, type: :system do
  let(:user) { create(:valid_user) }

  before do
    sign_in user, scope: :user
    visit root_path
  end

  describe "when visiting dashboard" do
    it "has today dashboard" do
      expect(page).to have_css("turbo-frame#today")
    end

    it "has new time entry button" do
      expect(page).to have_link(I18n.t("dashboard.time_entry.new_button"),
                                href: new_time_entry_path(format: :turbo_stream))
    end
  end

  describe "when creating time entry" do
    let(:form_selector) { "form[action='#{time_entries_path}']" }

    def open_time_entry_form
      click_link I18n.t("dashboard.time_entry.new_button")
      expect(page).to have_css(form_selector)
    end

    it "opening the form" do
      expect(page).to have_current_path(root_path, ignore_query: true)
      open_time_entry_form
    end

    it "with invalid data" do
      open_time_entry_form

      click_button "Create Time Entry"

      expect(page).to have_content("can't be blank")
      expect(page).to have_css(form_selector)
    end

    it "with valid data" do
      create(:project)

      open_time_entry_form

      fill_in "time_entry[name]", with: "Worked on something"
      fill_in "time_entry[time_from]", with: "10:15"
      fill_in "time_entry[time_to]", with: "11:15"
      click_button "Create Time Entry"

      expect(page).to have_no_css(form_selector)
      expect(page).to have_link(I18n.t("dashboard.time_entry.new_button"))
    end
  end
end
