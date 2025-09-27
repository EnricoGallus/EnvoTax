# frozen_string_literal: true

# Controller for cost types
class CostTypesController < ApplicationController
  before_action :set_cost_type, only: %i[show edit update destroy]

  # GET /cost_types
  def index
    @q = policy_scope(CostType).ransack(params[:q])
    @cost_types = @q.result(distinct: true)
  end

  # GET /cost_types/1
  def show; end

  # GET /cost_types/new
  def new
    @cost_type = CostType.new
  end

  # GET /cost_types/1/edit
  def edit; end

  # POST /cost_types
  def create
    @cost_type = current_user.cost_types.new(cost_type_params)

    if @cost_type.save
      redirect_to @cost_type, notice: t("cost_types.successfully_created")
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /cost_types/1
  def update
    if @cost_type.update(cost_type_params)
      redirect_to @cost_type, notice: t("cost_types.successfully_updated"), status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /cost_types/1
  def destroy
    @cost_type.destroy!
    redirect_to cost_types_path, notice: t("cost_types.successfully_destroyed"), status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cost_type
    @cost_type = authorize CostType.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def cost_type_params
    params.expect(cost_type: [:name])
  end
end
