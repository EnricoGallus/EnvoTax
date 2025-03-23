# frozen_string_literal: true

# Controller for IncomeTaxes
class IncomeTaxesController < ApplicationController
  before_action :set_income_tax, only: %i[show edit update destroy]

  # GET /income_taxes
  def index
    @q = IncomeTax.ransack(params[:q])
    @income_taxes = @q.result(distinct: true)
  end

  # GET /income_taxes/1
  def show; end

  # GET /income_taxes/new
  def new
    @income_tax = IncomeTax.new
  end

  # GET /income_taxes/1/edit
  def edit; end

  # POST /income_taxes
  def create
    @income_tax = IncomeTax.new(income_tax_params)

    if @income_tax.save
      redirect_to @income_tax, notice: "Income tax was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /income_taxes/1
  def update
    if @income_tax.update(income_tax_params)
      redirect_to @income_tax, notice: "Income tax was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /income_taxes/1
  def destroy
    @income_tax.destroy!
    redirect_to income_taxes_path, notice: "Income tax was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_income_tax
    @income_tax = IncomeTax.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def income_tax_params
    params.expect(income_tax: [:tax_type, :tax_rate])
  end
end
