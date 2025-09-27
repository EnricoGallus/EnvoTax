# frozen_string_literal: true

# Controller for PaymentAdjustments
class PaymentAdjustmentsController < ApplicationController
  before_action :set_payment_adjustment, only: %i[show edit update destroy]

  # GET /payment_adjustments
  def index
    @q = PaymentAdjustment.ransack(params[:q])
    @payment_adjustments = @q.result(distinct: true)
  end

  # GET /payment_adjustments/1
  def show; end

  # GET /payment_adjustments/new
  def new
    @payment_adjustment = PaymentAdjustment.new
  end

  # GET /payment_adjustments/1/edit
  def edit; end

  # POST /payment_adjustments
  def create
    @payment_adjustment = current_user.payment_adjustments.build(payment_adjustment_params)

    if @payment_adjustment.save
      redirect_to @payment_adjustment, notice: t("payment_adjustments.successfully_created")
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /payment_adjustments/1
  def update
    if @payment_adjustment.update(payment_adjustment_params)
      redirect_to @payment_adjustment, notice: t("payment_adjustment.successfully_updated"), status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /payment_adjustments/1
  def destroy
    @payment_adjustment.destroy!
    redirect_to payment_adjustments_path, notice: t("payment_adjustment.successfully_destroyed"), status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment_adjustment
    @payment_adjustment = PaymentAdjustment.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def payment_adjustment_params
    params.expect(payment_adjustment: [:client_id, :amount, :description, :date, :status])
  end
end
