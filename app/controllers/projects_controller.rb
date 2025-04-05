# frozen_string_literal: true

# project controller for crud
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show; end

  # GET /projects/new
  def new
    @project = Project.new
    populate_dropdowns
  end

  # GET /projects/1/edit
  def edit
    populate_dropdowns
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: t("projects.successfully_created") }
        format.json { render :show, status: :created, location: @project }
      else
        populate_dropdowns
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: t("projects.successfully_updated") }
        format.json { render :show, status: :ok, location: @project }
      else
        populate_dropdowns
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, status: :see_other, notice: t("projects.successfully_destroyed") }
      format.json { head :no_content }
    end
  end

  private

  def populate_dropdowns
    @clients = Client.pluck(:name, :id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.expect(project: [:name, :client_id])
  end
end
