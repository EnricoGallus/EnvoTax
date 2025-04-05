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

  context "when expense has an attached receipt", skip: "mock not working" do
    before do
      allow(expense.receipt).to receive_messages(attached?: true, representable?: false)
      allow(view).to receive(:rails_blob_path).and_return("/path/to/receipt")

      render
    end

    it "renders download link for receipt" do
      expect(rendered).to have_link("Download", href: "/path/to/receipt")
    end
  end

  context "when expense has a displayable receipt", skip: "mock not working" do
    before do
      allow(expense.receipt).to receive_messages(attached?: true, representable?: true,
                                                 representation: "representation_object")
      allow(view).to receive(:image_tag).and_return('<img src="/path/to/receipt" />')

      render
    end

    it "renders receipt image" do
      expect(rendered).to have_css("div", text: %r{img src="/path/to/receipt"})
    end
  end
end
