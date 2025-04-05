# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bank_accounts/_form.html.erb", type: :view do
  let(:bank_account) { build(:bank_account) }
  let(:form) do
    ActionView::Helpers::FormBuilder.new(
      :bank_account,
      bank_account,
      view,
      {}
    )
  end

  before do
    allow(bank_account).to receive(:errors).and_return({
                                                         account_holder: [],
                                                         bank_name: [],
                                                         branch_code: [],
                                                         account_number: []
                                                       })

    render partial: "bank_accounts/form", locals: { form: form, bank_account: bank_account }
  end

  it "renders the bank_account fieldset" do
    expect(rendered).to have_css("fieldset.fieldset")
    expect(rendered).to have_css("legend.fieldset-legend", text: I18n.t("activerecord.models.bank_account.one"))
  end

  it "renders postal account holder field" do
    expect(rendered).to have_field("bank_account[account_holder]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.bank_account.account_holder"))
  end

  it "renders bank name field" do
    expect(rendered).to have_field("bank_account[bank_name]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.bank_account.bank_name"))
  end

  it "renders branch code field" do
    expect(rendered).to have_field("bank_account[branch_code]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.bank_account.branch_code"))
  end

  it "renders account number field" do
    expect(rendered).to have_field("bank_account[account_number]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.bank_account.account_number"))
  end

  context "with validation errors" do
    before do
      allow(bank_account).to receive(:errors).and_return({
                                                           account_holder: ["is invalid"],
                                                           bank_name: [],
                                                           branch_code: [],
                                                           account_number: []
                                                         })

      render partial: "bank_accounts/form", locals: { form: form, bank_account: bank_account }
    end

    it "applies error styling to fields with errors" do
      expect(rendered).to have_field("bank_account[account_holder]", class: "border-red-400")
    end
  end
end
