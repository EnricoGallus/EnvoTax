# frozen_string_literal: true

# represents a job to process an invoice
class InvoiceProcessorJob < ApplicationJob
  queue_as :default

  def perform(params, current_user_id)
    clients = params[:client_id].present? ? Client.find(params[:client_id]) : Client.all
    user = User.find(current_user_id)

    clients.each do |client|
      InvoiceCreator.new(client, user, params[:start_date], params[:end_date]).call
    end
  end
end
