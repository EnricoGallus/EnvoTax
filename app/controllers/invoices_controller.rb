# frozen_string_literal: true

# controller for invoice handling
class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show destroy preview approve]

  # GET /invoices or /invoices.json
  def index
    @q = policy_scope(Invoice).ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  # GET /invoices/1 or /invoices/1.json
  def show; end

  def preview
    render layout: "invoice"
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = InvoiceIssuer.new(invoice_params)

    respond_to do |format|
      if @invoice.valid?
        InvoiceProcessorJob.perform_later(@invoice.to_h, current_user.id)
        format.html { redirect_to invoices_path, notice: t("invoices.successfully_created") }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @invoice.errors, status: :unprocessable_content }
      end
    end
  end

  def approve
    @invoice.approved!
    if @invoice.save
      redirect_to invoices_path, notice: t("invoices.status_change_to_approved")
    else
      render :show, status: :unprocessable_content
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
    @invoice = authorize Invoice.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.expect(invoice: [:client_id, :start_date, :end_date, :invoice_date])
  end
end
