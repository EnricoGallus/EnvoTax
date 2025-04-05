# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectsController, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    attributes_for(:project).merge(client_id: create(:client).id)
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      create(:project)
      get projects_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      project = create(:project)
      get project_url(project)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_project_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      project = create(:project)
      get edit_project_url(project)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Project" do
        expect do
          post projects_url, params: { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it "redirects to the created project" do
        post projects_url, params: { project: valid_attributes }
        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project" do
        expect do
          post projects_url, params: { project: invalid_attributes }
        end.not_to change(Project, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post projects_url, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: "Updated Project" }
      end
      let(:project) { create(:project) }

      before do
        patch project_url(project), params: { project: new_attributes }
        project.reload
      end

      it "updates the requested project name" do
        expect(project.name).to eq(new_attributes[:name])
      end

      it "redirects to the project" do
        expect(response).to redirect_to(project_url(project))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        project = create(:project)
        patch project_url(project), params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested project" do
      project = create(:project)
      expect do
        delete project_url(project)
      end.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      project = create(:project)
      delete project_url(project)
      expect(response).to redirect_to(projects_url)
    end
  end
end
