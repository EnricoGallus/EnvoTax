# frozen_string_literal: true

# Controller for PaymentAllocations
class PaymentAllocationsController < ApplicationController
  before_action :set_payment_statement
  before_action :set_payment_allocation, only: %i[show edit update destroy]

  # TODO: This should be added to payment_statements_controller show method and than removed. index is not routed
  def index
    @q = PaymentAllocation.ransack(params[:q])
    @payment_allocations = @q.result(distinct: true)
  end

  # GET /payment_allocations/1
  def show; end

  # GET /payment_allocations/new
  def new
    @payment_allocation = @payment_statement.payment_allocations.new
    reference_list
  end

  # GET /payment_allocations/1/edit
  def edit
    reference_list
  end

  # POST /payment_allocations
  def create
    @payment_allocation = @payment_statement.payment_allocations.build(payment_allocation_params)

    if @payment_allocation.save
      redirect_to payment_statement_path(@payment_statement), notice: t("payment_allocation.successfully_created")
    else
      reference_list
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payment_allocations/1
  def update
    if @payment_allocation.update(payment_allocation_params)
      redirect_to payment_statement_path(@payment_statement), notice: t("payment_allocation.successfully_updated"),
                                                              status: :see_other
    else
      reference_list
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /payment_allocations/1
  def destroy
    @payment_allocation.destroy!
    redirect_to payment_statement_path(@payment_statement), notice: t("payment_allocation.successfully_destroyed"),
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

  # TODO: play around with view component, maybe we can optimize not calling it in every controller action
  def reference_list
    @references = (Invoice.all + PaymentAdjustment.all).map do |ref|
      [
        "#{ref.class.name} ##{ref.id} – #{ref.details}",
        "#{ref.class.name}_#{ref.id}"
      ]
    end
  end

  # Only allow a list of trusted parameters through.
  def payment_allocation_params
    params.expect(payment_allocation: [:amount, :income_tax_id, :payment_statement_id, :reference_id, :reference_type])
  end
end
