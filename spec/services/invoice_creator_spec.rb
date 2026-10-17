# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvoiceCreator do
  subject(:create_invoice) { described_class.new(contract, user, start_date, end_date, invoice_date).call }

  let(:user) { create(:user) }
  let(:client) { create(:client, user: user, hourly_rate: 1000) }
  let(:contract) { create(:contract, client: client, user: user, process_time_entries: true) }
  let!(:contract_instance) do
    create(:contract_instance, contract: contract, start_date: start_date, end_date: end_date)
  end
  let(:start_date) { Date.new(2025, 12, 1) }
  let(:end_date) { Date.new(2025, 12, 31) }
  let(:invoice_date) { Date.new(2026, 1, 5) }
  let(:project) { create(:project, client: client) }

  describe "#call" do
    it "persists a draft invoice with the supplied dates and associations" do
      expect { create_invoice }.to change(Invoice, :count).by(1)

      expect(create_invoice.reload).to have_attributes(
        client: client,
        contract_instance: contract_instance,
        user: user,
        start_date: start_date,
        end_date: end_date,
        invoice_date: invoice_date,
        status: "draft",
        period: 2026,
        calculation_mode: client.calculation_mode,
        total_amount: Money.new(0, "JPY")
      )
    end

    it "copies the client's total-based calculation mode" do
      client.update!(calculation_mode: :total_based)

      expect(create_invoice.reload.calculation_mode).to eq("total_based")
    end

    it "selects the contract instance covering the entire billing period" do
      create(:contract_instance, contract: contract, start_date: start_date - 1.month, end_date: start_date - 1.day)

      expect(create_invoice.contract_instance).to eq(contract_instance)
    end

    context "with time entries" do
      it "assigns entries from all of the client's projects, including both date boundaries" do
        another_project = create(:project, client: client)
        first_entry = create(:time_entry, project: project, date: start_date)
        last_entry = create(:time_entry, project: another_project, date: end_date)

        expect(create_invoice.time_entries).to contain_exactly(first_entry, last_entry)
      end

      it "leaves entries outside the period or belonging to another client unassigned" do
        before_period = create(:time_entry, project: project, date: start_date - 1.day)
        after_period = create(:time_entry, project: project, date: end_date + 1.day)
        other_client_entry = create(:time_entry, date: start_date)

        expect(create_invoice.time_entries).to be_empty
        expect([before_period, after_period, other_client_entry].map { |entry| entry.reload.invoice_id })
          .to all(be_nil)
      end

      it "keeps already invoiced entries on their original invoice" do
        existing_invoice = create(:invoice, client: client, user: user, contract_instance: contract_instance)
        entry = create(:time_entry, project: project, date: start_date, invoice: existing_invoice)

        expect(create_invoice.time_entries).to be_empty
        expect(entry.reload.invoice).to eq(existing_invoice)
      end

      it "does not assign time entries when the contract disables their processing" do
        contract.update!(process_time_entries: false)
        entry = create(:time_entry, project: project, date: start_date)
        expense = create(:expense, contract_instance: contract_instance, date: start_date, amount_cents: 2000)

        expect(create_invoice.time_entries).to be_empty
        expect(entry.reload.invoice).to be_nil
        expect(create_invoice.expenses).to contain_exactly(expense)
        expect(create_invoice.reload.total_amount).to eq(expense.amount)
      end
    end

    context "with expenses" do
      it "assigns expenses for the selected contract instance, including both date boundaries" do
        first_expense = create(:expense, contract_instance: contract_instance, date: start_date)
        last_expense = create(:expense, contract_instance: contract_instance, date: end_date)

        expect(create_invoice.expenses).to contain_exactly(first_expense, last_expense)
      end

      it "leaves expenses outside the period or belonging to another instance unassigned" do
        other_instance = create(:contract_instance, contract: contract, start_date: start_date, end_date: end_date)
        before_period = create(:expense, contract_instance: contract_instance, date: start_date - 1.day)
        after_period = create(:expense, contract_instance: contract_instance, date: end_date + 1.day)
        other_expense = create(:expense, contract_instance: other_instance, date: start_date)
        unassigned_expense = create(:expense, contract_instance: nil, date: start_date)

        expect(create_invoice.expenses).to be_empty
        excluded_expenses = [before_period, after_period, other_expense, unassigned_expense]
        expect(excluded_expenses.map { |expense| expense.reload.invoice_id }).to all(be_nil)
      end

      it "keeps already invoiced expenses on their original invoice" do
        existing_invoice = create(:invoice, client: client, user: user, contract_instance: contract_instance)
        expense = create(:expense, contract_instance: contract_instance, date: start_date, invoice: existing_invoice)

        expect(create_invoice.expenses).to be_empty
        expect(expense.reload.invoice).to eq(existing_invoice)
      end
    end

    it "persists the total calculated from the assigned time entries, debits, and credits" do
      entry = create(:time_entry, project: project, date: start_date)
      create(:expense, contract_instance: contract_instance, date: start_date, amount_cents: 2000)
      create(:expense, contract_instance: contract_instance, date: end_date,
                       amount_cents: 500, transaction_type: :credit)

      expect(create_invoice.reload.total_amount).to eq(entry.cost + Money.new(1500, "JPY"))
    end

    context "when saving the calculated total fails" do
      it "raises the validation error and rolls back the invoice and all assignments" do
        entry = create(:time_entry, project: project, date: start_date)
        expense = create(:expense, contract_instance: contract_instance, date: start_date,
                                   amount_cents: 100_000, transaction_type: :credit)

        expect do
          expect { create_invoice }.to raise_error(ActiveRecord::RecordInvalid)
        end.not_to change(Invoice, :count)

        expect(entry.reload.invoice).to be_nil
        expect(expense.reload.invoice).to be_nil
      end
    end

    context "when no contract instance covers the billing period" do
      it "raises a validation error without creating an invoice" do
        contract_instance.update!(end_date: end_date - 1.day)

        expect do
          expect { create_invoice }.to raise_error(ActiveRecord::RecordInvalid)
        end.not_to change(Invoice, :count)
      end
    end
  end
end
