# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvoiceProcessorJob, type: :job do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:invoice_creator) { instance_double(InvoiceCreator) }

  before do
    allow(InvoiceCreator).to receive(:new).and_return(invoice_creator)
    allow(invoice_creator).to receive(:call)
  end

  describe "#perform" do
    it "processes invoices for a specific client" do
      params = { client_id: client.id, start_date: Time.zone.now, end_date: Time.zone.now, category_id: 1 }

      allow(Client).to receive(:find).with(client.id).and_return(client)
      allow(InvoiceCreator).to receive(:new).and_return(invoice_creator)

      described_class.perform_now(params, user.id)

      expect(InvoiceCreator).to have_received(:new)
        .with(client, user, params[:start_date], params[:end_date], params[:category_id])
      expect(invoice_creator).to have_received(:call)
    end

    it "processes invoices for all clients when no client specified" do
      params = { start_date: Time.zone.now, end_date: Time.zone.now, category_id: 1 }
      all_clients = create_list(:client, 2)

      expect(Client).to receive(:all).and_return(all_clients)

      all_clients.each do |client|
        expect(InvoiceCreator).to receive(:new).with(client, user, params[:start_date], params[:end_date],
                                                     params[:category_id]).and_return(invoice_creator)
        expect(invoice_creator).to receive(:call)
      end

      described_class.perform_now(params, user.id)
    end
  end
end
