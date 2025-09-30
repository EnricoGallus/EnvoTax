# frozen_string_literal: true

# controller for the time entries
class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: %i[edit update destroy]

  # GET /time_entries or /time_entries.json
  def index
    @q = TimeEntry.ransack(params[:q])
    @pagy, @time_entries = pagy(@q.result(distinct: true).order(date: :desc, time_from: :desc))
  end

  # GET /time_entries/new
  def new
    @time_entry = TimeEntry.new
    @time_entry.date = Time.zone.today
  end

  # GET /time_entries/1/edit
  def edit; end

  # POST /time_entries or /time_entries.json
  def create
    @time_entry = TimeEntry.new(time_entry_params)

    respond_to do |format|
      if @time_entry.save
        format.html { redirect_to @time_entry, notice: t("time_entry.successfully_created") }
        format.turbo_stream { render "dashboard/new_time_entry", status: :created }
      else
        format.html { render :new, status: :unprocessable_content }
        format.turbo_stream { render :new, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /time_entries/1 or /time_entries/1.json
  def update
    respond_to do |format|
      if @time_entry.update(time_entry_params)
        format.html { redirect_to @time_entry, notice: t("time_entry.successfully_updated") }
        format.json { render :show, status: :ok, location: @time_entry }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @time_entry.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /time_entries/1 or /time_entries/1.json
  def destroy
    @time_entry.destroy!

    respond_to do |format|
      format.html do
        redirect_to time_entries_path, status: :see_other, notice: t("time_entry.successfully_destroyed")
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_time_entry
    @time_entry = TimeEntry.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def time_entry_params
    params.expect(time_entry: [:date, :time_from, :time_to, :name, :project_id])
  end
end
