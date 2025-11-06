# frozen_string_literal: true

# represents a job to process an invoice
class InvoiceProcessorJob < ApplicationJob
  queue_as :default

  def perform(params, current_user_id)
    contracts = params[:contract_id].present? ? [Contract.find(params[:contract_id])] : Contract.all
    user = User.find(current_user_id)

    contracts.each do |contract|
      InvoiceCreator.new(contract, user, params[:start_date], params[:end_date], params[:invoice_date]).call
    end
  end
end
