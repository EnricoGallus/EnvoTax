# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvoiceAmountCalculator do
  let(:invoice) { create(:invoice, calculation_mode: calculation_mode) }
  let(:calculator) { described_class.new(invoice) }
  let(:client) { create(:client, hourly_rate: 1000) }
  let(:project) { create(:project, client: client) }

  describe "#call" do
    context "when calculation mode is :item_based" do
      let(:calculation_mode) { :item_based }

      it "calculates the total based on time entries and expenses" do
        create(:time_entry, :with_duration, hours: 4, minutes: 20, slot_index: 0, invoice: invoice, project: project)
        create(:time_entry, :with_duration, hours: 3, minutes: 20, slot_index: 1, invoice: invoice, project: project)
        create(:expense, invoice: invoice, amount_cents: 2000, transaction_type: :debit)
        create(:expense, invoice: invoice, amount_cents: 1000, transaction_type: :credit)

        expect(calculator.call).to eq(Money.new(8_666))
      end
    end

    context "when calculation mode is :total_based" do
      let(:calculation_mode) { :total_based }

      it "calculates the total based on spent time and hourly rate" do
        create(:time_entry, :with_duration, hours: 4, minutes: 20, slot_index: 0, invoice: invoice, project: project)
        create(:time_entry, :with_duration, hours: 3, minutes: 20, slot_index: 1, invoice: invoice, project: project)
        create(:expense, invoice: invoice, amount_cents: 2000, transaction_type: :debit)
        create(:expense, invoice: invoice, amount_cents: 1000, transaction_type: :credit)

        contract = create(:contract, client: client)
        contract_instance = create(:contract_instance, contract: contract)
        invoice.update!(contract_instance: contract_instance)

        expect(calculator.call).to eq(Money.new(8_667))
      end
    end

    context "when calculation mode is unsupported" do
      let(:calculation_mode) { :unsupported_mode }

      it "raises an ArgumentError" do
        expect { calculator.call }.to raise_error(ArgumentError, "'unsupported_mode' is not a valid calculation_mode")
      end
    end
  end
end
