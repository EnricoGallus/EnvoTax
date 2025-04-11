# frozen_string_literal: true

# controller for invoice handling
class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show destroy]

  # GET /invoices or /invoices.json
  def index
    @q = Invoice.ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  # GET /invoices/1 or /invoices/1.json
  def show
    respond_to do |format|
      format.pdf do
        @user = current_user
        render pdf: "invoice_#{@invoice.id}",
               template: "invoices/show",
               layout: "invoice",
               disposition: "inline",
               viewport_size: "1280x1024",
               page_size: "A4",
               orientation: "Portrait"
      end
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.valid?(:job)
        InvoiceProcessorJob.perform_later(invoice_params, current_user.id, params[:invoice][:contract_id])
        format.html { redirect_to invoices_path, notice: t("invoices.successfully_created") }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_path, status: :see_other, notice: t("invoices.successfully_destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.expect(invoice: [:client_id, :start_date, :end_date, :invoice_date])
  end
end
