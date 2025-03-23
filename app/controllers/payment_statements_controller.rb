# frozen_string_literal: true

# controller for payment statements
class PaymentStatementsController < ApplicationController
  before_action :set_payment_statement, only: %i[show edit update destroy]

  # GET /payment_statements
  def index
    @q = PaymentStatement.ransack(params[:q])
    @payment_statements = @q.result(distinct: true)
  end

  # GET /payment_statements/1
  def show; end

  # GET /payment_statements/new
  def new
    @payment_statement = PaymentStatement.new
  end

  # GET /payment_statements/1/edit
  def edit; end

  # POST /payment_statements
  def create
    @payment_statement = current_user.payment_statements.build(payment_statement_params)

    if @payment_statement.save
      redirect_to @payment_statement, notice: "Payment statement was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payment_statements/1
  def update
    if @payment_statement.update(payment_statement_params)
      redirect_to @payment_statement, notice: "Payment statement was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /payment_statements/1
  def destroy
    @payment_statement.destroy!
    redirect_to payment_statements_path, notice: "Payment statement was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment_statement
    @payment_statement = PaymentStatement.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def payment_statement_params
    params.expect(payment_statement: [:client_id, :amount, :received_on, :receipt])
  end
end
