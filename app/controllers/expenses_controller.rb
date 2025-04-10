# frozen_string_literal: true

# Controller for Expenses
class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_contract_instance, only: %i[create update]

  # GET /expenses or /expenses.json
  def index
    @q = Expense.ransack(params[:q])
    @expenses = @q.result(distinct: true)
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit; end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: t("expense.successfully_created") }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: t("expense.successfully_updated") }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to expenses_path, status: :see_other, notice: t("expense.successfully_destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params.expect(:id))
  end

  def set_contract_instance
    return unless params[:expense][:contract_id].present? && params[:expense][:date].present?

    contract = Contract.find(params[:expense][:contract_id])
    @expense.contract_instance = contract.active_instance_by_date(params[:expense][:date])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.expect(expense: [:amount, :cost_type_id, :description, :date, :receipt, :contract_instance_id,
                            :transaction_type])
  end
end
