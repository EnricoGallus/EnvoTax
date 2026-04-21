# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/show", type: :view do
  let(:user) { create(:valid_user) }
  let(:client) { create(:valid_client, user: user, hourly_rate_cents: 5_000) }
  let(:contract) { create(:contract, client: client, user: user) }
  let(:contract_instance) { create(:contract_instance, contract: contract) }
  let(:invoice) { create(:invoice, user: user, contract_instance: contract_instance) }

  before do
    assign(:invoice, invoice)
    sign_in user
    enable_pundit(view, user)
    render
  end

  context "without line items" do
    before { render }

    it "renders the wrapper and header title" do
      expect(rendered).to have_css("#invoice")
      expect(rendered).to have_css("h1", text: I18n.t("invoice.header.title"))
    end

    it "renders action buttons (approve when draft and owner)" do
      expect(rendered).to have_button(I18n.t("invoice.approve"))
      expect(rendered).to have_link(I18n.t("table.back"))
      expect(rendered).to have_button(I18n.t("table.delete"))
    end

    it "renders header details (date and reference number)" do
      expect(rendered).to include(I18n.l(invoice.invoice_date, format: :default))
      expect(rendered).to include(invoice.invoice_number)
    end

    it "renders client (to) and user (from) sections" do
      # To (client)
      expect(rendered).to include(I18n.t("invoice.to.title"))
      expect(rendered).to include(client.name)
      expect(rendered).to include(client.address.postal_code)
      expect(rendered).to include(client.address.to_formatted_address)

      # From (current_user)
      expect(rendered).to include(I18n.t("invoice.from.title"))
      expect(rendered).to include(user.name)
      expect(rendered).to include(user.address.postal_code)
      expect(rendered).to include(user.address.to_formatted_address)
      expect(rendered).to include(user.email)
    end

    it "renders total amount summary and table total" do
      formatted_total = invoice.total_amount_cents.to_money.format
      expect(rendered).to include(I18n.t("invoice.billing_details.total_amount"))
      expect(rendered).to include(formatted_total)
      expect(rendered).to include(I18n.t("invoice.billing_details.total"))
    end

    it "renders bank details and tax notice" do
      expect(rendered).to include(I18n.t("invoice.bank_details.title"))
      expect(rendered).to include(user.bank_account.account_holder)
      expect(rendered).to include(user.bank_account.bank_name)
      expect(rendered).to include(user.bank_account.branch_code)
      expect(rendered).to include(user.bank_account.account_number)
      expect(rendered).to include(I18n.t("invoice.tax.included"))
    end
  end

  context "with expenses" do
    let!(:expense) do
      create(:expense, :with_receipt, invoice: invoice, contract_instance: contract_instance, amount_cents: 2000)
    end

    before { render }

    it "renders expenses section and a row with details" do
      expect(rendered).to include(I18n.t("activerecord.models.expense.other"))
      expect(rendered).to include(I18n.l(expense.date, format: :default))
      expect(rendered).to include(expense.description)
      expect(rendered).to include(expense.amount.format)
    end

    it "renders download link for receipt" do
      expect(rendered).to have_link("Download", href: rails_blob_path(expense.receipt, disposition: "attachment"))
    end
  end

  context "with time entries" do
    let!(:time_entry) { create(:time_entry, :with_duration, hours: 4, invoice: invoice, cost_cents: 5000) }

    before { render }

    it "renders the aggregated work row and grouped breakdown" do
      # Aggregated header row
      expect(rendered).to include(I18n.t("invoice.header.work"))
      expect(rendered).to include(I18n.t("invoice.header.period", from: I18n.l(invoice.start_date, format: :default),
                                                                  to: I18n.l(invoice.end_date, format: :default)))

      # Grouped breakdown header
      expect(rendered).to include(I18n.t("invoice.billing_details.grouped_breakdown"))

      # Group row for the project
      expect(rendered).to include(time_entry.project.name)
      expect(rendered).to include("04h:00m")

      # Hourly rate
      expect(rendered).to include(client.hourly_rate_cents.to_money.format)
    end
  end
end
