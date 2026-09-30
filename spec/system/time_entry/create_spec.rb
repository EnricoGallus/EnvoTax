# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Creation", type: :system do
  let(:user) { create(:valid_user) }

  before do
    sign_in user, scope: :user
    visit time_entries_path
  end

  describe "when creating time entry" do
    let(:form_selector) { "form[action='#{time_entries_path}']" }

    it "redirects to new page" do
      expect(page).to have_current_path(time_entries_path)

      click_link I18n.t("time_entry.index.new")

      expect(page).to have_current_path(new_time_entry_path)
    end

    it "with invalid data" do
      click_link I18n.t("time_entry.index.new")
      expect(page).to have_css(form_selector)

      click_button "Create Time Entry"

      expect(page).to have_text("can't be blank")
      expect(page).to have_css(form_selector)
    end

    it "with valid data" do
      create(:project)

      click_link I18n.t("time_entry.index.new")
      expect(page).to have_css(form_selector)

      fill_in "time_entry[name]", with: "Worked on something"
      fill_in "time_entry[time_from]", with: "10:15"
      fill_in "time_entry[time_to]", with: "11:15"
      expect { click_button "Create Time Entry" }.to change(TimeEntry, :count).by(1)

      expect(page).to have_text(I18n.t("time_entry.successfully_created"))
      expect(page).to have_current_path(time_entry_path(TimeEntry.last))
    end
  end
end
