# frozen_string_literal: true

class ContractsController < ApplicationController
  before_action :set_contract, only: %i[show edit update destroy]

  # GET /contracts
  def index
    @q = Contract.ransack(params[:q])
    @contracts = @q.result(distinct: true)
  end

  # GET /contracts/1
  def show; end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit; end

  # POST /contracts
  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      redirect_to @contract, notice: "Contract was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contracts/1
  def update
    if @contract.update(contract_params)
      redirect_to @contract, notice: "Contract was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /contracts/1
  def destroy
    @contract.destroy!
    redirect_to contracts_path, notice: "Contract was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contract
    @contract = Contract.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def contract_params
    params.expect(contract: [:name, :client_id, :budget_limit, :start_date, :end_date])
  end
end
