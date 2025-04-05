# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvoiceProcessorJob, type: :job do
  let(:user) { create(:user) }
  let(:contract) { create(:contract) }
  let(:invoice_creator) { instance_double(InvoiceCreator) }

  before do
    allow(InvoiceCreator).to receive(:new).and_return(invoice_creator)
    allow(invoice_creator).to receive(:call)
  end

  describe "#perform" do
    it "processes invoices for a specific contract" do
      params = { contract_id: contract.id, start_date: Time.zone.now, end_date: Time.zone.now }

      allow(Contract).to receive(:find).with(contract.id).and_return(contract)
      allow(InvoiceCreator).to receive(:new).and_return(invoice_creator)

      described_class.perform_now(params, user.id, contract.id)

      expect(InvoiceCreator).to have_received(:new)
        .with(contract, user, params[:start_date], params[:end_date], params[:category_id])
      expect(invoice_creator).to have_received(:call)
    end

    it "processes invoices for all contracts when no contract specified" do
      params = { start_date: Time.zone.now, end_date: Time.zone.now }
      all_contracts = create_list(:contract, 2)

      expect(Contract).to receive(:all).and_return(all_contracts)

      all_contracts.each do |contract|
        expect(InvoiceCreator).to receive(:new).with(contract, user, params[:start_date], params[:end_date],
                                                     params[:category_id]).and_return(invoice_creator)
        expect(invoice_creator).to receive(:call)
      end

      described_class.perform_now(params, user.id, nil)
    end
  end
end
