# frozen_string_literal: true

class PaymentAllocationsController < ApplicationController
  before_action :set_payment_statement
  before_action :set_payment_allocation, only: %i[show edit update destroy]

  # TODO: This should be added to payment_statements_controller show method
  def index
    @q = PaymentAllocation.ransack(params[:q])
    @payment_allocations = @q.result(distinct: true)
  end

  # GET /payment_allocations/1
  def show; end

  # GET /payment_allocations/new
  def new
    @payment_allocation = @payment_statement.payment_allocations.new
  end

  # GET /payment_allocations/1/edit
  def edit; end

  # POST /payment_allocations
  def create
    @payment_allocation = @payment_statement.payment_allocations.build(payment_allocation_params)

    if @payment_allocation.save
      redirect_to payment_statement_path(@payment_statement), notice: "Payment allocation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payment_allocations/1
  def update
    if @payment_allocation.update(payment_allocation_params)
      redirect_to payment_statement_path(@payment_statement), notice: "Payment allocation was successfully updated.",
                                                              status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /payment_allocations/1
  def destroy
    @payment_allocation.destroy!
    redirect_to payment_statement_path(@payment_statement), notice: "Payment allocation was successfully destroyed.",
                                                            status: :see_other
  end

  private

  def set_payment_statement
    @payment_statement = PaymentStatement.find(params[:payment_statement_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_payment_allocation
    @payment_allocation = PaymentAllocation.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def payment_allocation_params
    base_params = params.expect(payment_allocation: [:amount, :income_tax_id, :payment_statement_id, :allocate_to])
    return if params[:payment_allocation][:allocate_to].blank?

    reference_type, reference_id = params[:payment_allocation][:allocate_to].split("_")
    base_params[:reference_type] = reference_type
    base_params[:reference_id] = reference_id
    base_params.delete(:allocate_to)
    base_params
  end
end
