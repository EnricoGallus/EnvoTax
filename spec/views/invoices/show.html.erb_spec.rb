# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/show", type: :view do
  let(:user) { create(:user, :with_all_associations) }
  let(:invoice) { create(:invoice) }

  before do
    assign(:invoice, invoice)
    view.stub(:current_user).and_return(user)
    render
  end

  it "renders invoice header" do
    expect(rendered).to have_css("#invoice")
    expect(rendered).to have_css("h1", text: I18n.t("invoice.header.title"))
  end

  it "renders the client information" do
    expect(rendered).to have_content(invoice.contract_instance.contract.client.name)
    expect(rendered).to have_content(invoice.contract_instance.contract.client.address)
  end

  it "renders the invoice details", skip: "under construction" do
    expect(rendered).to have_content("Date: #{invoice.created_at.strftime('%B %d, %Y')}")
    start_date = invoice.start_date.strftime("%B %d, %Y")
    end_date = invoice.end_date.strftime("%B %d, %Y")
    period_text = "Period: #{start_date} - #{end_date}"
    expect(rendered).to have_content(period_text)
    expect(rendered).to have_content("Status: #{invoice.status.humanize}")
  end

  context "when time entries exist", skip: "under construction" do
    it "renders the time entries table" do
      expect(rendered).to have_content(t("activerecord.models.time_entry.other"))
      expect(rendered).to have_content("May 10, 2023")
      expect(rendered).to have_content("Test Project")
      expect(rendered).to have_content("09:00")
      expect(rendered).to have_content("13:00")
    end
  end

  context "when expenses exist", skip: "under construction" do
    it "renders the expenses table" do
      expect(rendered).to have_content(t("activerecord.models.expense.other"))
      expect(rendered).to have_content("May 12, 2023")
      expect(rendered).to have_content("Office supplies")
      expect(rendered).to have_content("$100.00")
    end
  end

  it "renders the total amount" do
    expect(rendered).to have_content(I18n.t("invoice.billing_details.total"))
    expect(rendered).to have_content(invoice.total_amount.format)
  end

  context "when expense has an attached receipt", skip: "under construction" do
    before do
      allow(Base64).to receive(:strict_encode64).and_return("base64-encoded-data")
    end

    it "renders the expense receipt" do
      expect(rendered).to have_css("img[src*='data:image/jpeg;base64']")
    end
  end
end
