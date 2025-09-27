# frozen_string_literal: true

require "rails_helper"

RSpec.describe TimeEntriesController, type: :request do
  let(:project) { create(:project) }
  let(:user) { create(:user) }
  let(:valid_attributes) do
    attributes_for(:time_entry).merge(project_id: project.id)
  end

  let(:invalid_attributes) do
    { name: nil, project_id: nil }
  end

  before do
    sign_in user, scope: :user
  end

  describe "GET /index" do
    it "renders a successful response" do
      TimeEntry.create! valid_attributes
      get time_entries_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_time_entry_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      time_entry = TimeEntry.create! valid_attributes
      get edit_time_entry_url(time_entry)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new TimeEntry" do
        expect do
          post time_entries_url, params: { time_entry: valid_attributes }
        end.to change(TimeEntry, :count).by(1)
      end

      it "redirects to the created time_entry" do
        post time_entries_url, params: { time_entry: valid_attributes }
        expect(response).to redirect_to(time_entry_url(TimeEntry.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new TimeEntry" do
        expect do
          post time_entries_url, params: { time_entry: invalid_attributes }
        end.not_to change(TimeEntry, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post time_entries_url, params: { time_entry: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "changes" }
      end

      it "updates the requested time_entry" do
        time_entry = TimeEntry.create! valid_attributes
        patch time_entry_url(time_entry), params: { time_entry: new_attributes }
        time_entry.reload

        expect(time_entry.name).to eq("changes")
      end

      it "redirects to the time_entry" do
        time_entry = TimeEntry.create! valid_attributes
        patch time_entry_url(time_entry), params: { time_entry: new_attributes }
        time_entry.reload
        expect(response).to redirect_to(time_entry_url(time_entry))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        time_entry = create(:time_entry)
        patch time_entry_url(time_entry), params: { time_entry: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested time_entry" do
      time_entry = TimeEntry.create! valid_attributes
      expect do
        delete time_entry_url(time_entry)
      end.to change(TimeEntry, :count).by(-1)
    end

    it "redirects to the time_entries list" do
      time_entry = TimeEntry.create! valid_attributes
      delete time_entry_url(time_entry)
      expect(response).to redirect_to(time_entries_url)
    end
  end
end
