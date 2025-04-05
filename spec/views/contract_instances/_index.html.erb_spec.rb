# frozen_string_literal: true

require "rails_helper"

RSpec.describe "contract_instances/_index", type: :view do
  let(:contract) { create(:contract) }
  let(:contract_instance) { create(:contract_instance, contract: contract) }
  let(:contract_instances) { [contract_instance] }

  before do
    allow(view).to receive(:sort_link) do |_q, _field, title|
      title
    end

    assign(:contract_instances, contract_instances)
    assign(:contract, contract)
    assign(:q, ContractInstance.ransack)

    render partial: "contract_instances/index", locals: { contract_instances: contract_instances, contract: contract }
  end

  context "when there are contract instances" do
    it "renders the title and new contract instance button" do
      expect(rendered).to have_css("h1", text: I18n.t("contract_instance.index.title"))
      expect(rendered).to have_link(I18n.t("contract_instance.index.new"),
                                    href: new_contract_contract_instance_path(contract))
    end

    it "renders the contract instances table with headers" do
      expect(rendered).to have_table(class: "table")
      expect(rendered).to have_css("th", text: I18n.t("activerecord.attributes.contract_instance.contract"))
      expect(rendered).to have_css("th", text: I18n.t("activerecord.attributes.contract_instance.start_date"))
      expect(rendered).to have_css("th", text: I18n.t("activerecord.attributes.contract_instance.end_date"))
      expect(rendered).to have_css("th", text: I18n.t("activerecord.attributes.contract_instance.budget_limit"))
      expect(rendered).to have_css("th", text: I18n.t("table.actions"))
    end

    it "renders contract instance details" do
      expect(rendered).to have_css("td", text: contract_instance.contract.name)
      expect(rendered).to have_css("td", text: contract_instance.start_date.to_s)
      expect(rendered).to have_css("td", text: contract_instance.end_date.to_s)
    end

    it "renders action buttons for each contract instance" do
      expect(rendered).to have_link(I18n.t("table.edit"),
                                    href: edit_contract_contract_instance_path(contract, contract_instance))
      expect(rendered).to have_button(I18n.t("table.delete"))
    end
  end

  context "when there are no contract instances" do
    let(:contract_instances) { [] }

    it "renders a message indicating no contract instances found" do
      expect(rendered).to have_css("p", text: I18n.t("contract_instance.index.none_found"))
    end

    it "does not render the table" do
      expect(rendered).to have_no_table(class: "table")
    end
  end
end
