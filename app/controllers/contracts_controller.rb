# frozen_string_literal: true

# ContractsController manages the CRUD operations for contracts.
class ContractsController < ApplicationController
  before_action :set_contract, only: %i[show edit update destroy]

  # GET /contracts
  def index
    @q = policy_scope(Contract).ransack(params[:q])
    @contracts = @q.result(distinct: true)
  end

  # GET /contracts/1
  def show
    @q = @contract.contract_instances.ransack(params[:q])
    @contract_instances = @q.result(distinct: true)
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit; end

  # POST /contracts
  def create
    @contract = current_user.contracts.new(contract_params)

    if @contract.save
      redirect_to @contract, notice: t("contract.successfully_created")
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /contracts/1
  def update
    if @contract.update(contract_params)
      redirect_to @contract, notice: t("cost_types.successfully_updated"), status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /contracts/1
  def destroy
    @contract.destroy!
    redirect_to contracts_path, notice: t("contract.successfully_destroyed"), status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contract
    @contract = authorize Contract.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def contract_params
    params.expect(contract: [:name, :client_id, :process_time_entries])
  end
end
