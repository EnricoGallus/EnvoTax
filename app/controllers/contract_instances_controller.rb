# frozen_string_literal: true

# controller for contract instances
class ContractInstancesController < ApplicationController
  before_action :set_contract
  before_action :set_contract_instance, only: %i[show edit update destroy]

  # GET /contract_instances/1
  def show; end

  # GET /contract_instances/new
  def new
    @contract_instance = @contract.contract_instances.new
  end

  # GET /contract_instances/1/edit
  def edit; end

  # POST /contract_instances
  def create
    @contract_instance = @contract.contract_instances.new(contract_instance_params)

    if @contract_instance.save
      redirect_to contract_path(@contract), notice: t("contract_instance.successfully_created")
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /contract_instances/1
  def update
    if @contract_instance.update(contract_instance_params)
      redirect_to contract_contract_instance_path(@contract, @contract_instance),
                  notice: t("contract_instance.successfully_updated"), status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /contract_instances/1
  def destroy
    @contract_instance.destroy!
    redirect_to contract_path(@contract), notice: t("contract_instance.successfully_destroyed"), status: :see_other
  end

  private

  def set_contract
    @contract = Contract.find(params.expect(:contract_id))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_contract_instance
    @contract_instance = @contract.contract_instances.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def contract_instance_params
    params.expect(contract_instance: [:contract_id, :start_date, :end_date, :budget_limit])
  end
end
