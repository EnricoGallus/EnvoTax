# frozen_string_literal: true

require "rails_helper"

RSpec.describe "expenses/show", type: :view do
  let(:expense) { create(:expense) }

  before do
    assign(:expense, expense)
    render
  end

  it "renders page title" do
    expect(rendered).to have_css("h1", text: "Showing expense")
  end

  it "renders the expense partial" do
    expect(rendered).to have_css("div#expense_#{expense.id}")
  end

  it "displays expense details" do
    expect(rendered).to have_content(expense.amount.format)
    expect(rendered).to have_content(expense.date)
    expect(rendered).to have_content(expense.cost_type.name)
    expect(rendered).to have_content(expense.description)
    expect(rendered).to have_content(expense.contract_instance.name)
  end

  it "renders action buttons" do
    expect(rendered).to have_link(I18n.t("table.edit"), href: edit_expense_path(expense))
    expect(rendered).to have_link(I18n.t("table.back"), href: expenses_path)
    expect(rendered).to have_button(I18n.t("table.delete"))
  end

  context "when expense has an attached receipt" do
    let(:expense) { create(:expense, :with_receipt) }

    it "renders download link for receipt" do
      expect(rendered).to have_css("img[src='#{rails_blob_path(expense.receipt)}']")
    end
  end
end
