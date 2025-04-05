# frozen_string_literal: true

require "rails_helper"

RSpec.describe "addresses/_form.html.erb", type: :view do
  let(:address) { build(:address) }
  let(:form) do
    ActionView::Helpers::FormBuilder.new(
      :address,
      address,
      view,
      {}
    )
  end

  before do
    allow(address).to receive(:errors).and_return({
                                                    postal_code: [],
                                                    prefecture: [],
                                                    city: [],
                                                    street: [],
                                                    building: [],
                                                    country: []
                                                  })

    allow(Address).to receive(:countries).and_return({
                                                       "japan" => "Japan",
                                                       "usa" => "USA"
                                                     })

    render partial: "addresses/form", locals: { form: form, address: address }
  end

  it "renders the address fieldset" do
    expect(rendered).to have_css("fieldset.fieldset")
    expect(rendered).to have_css("legend.fieldset-legend", text: I18n.t("activerecord.models.address.one"))
  end

  it "renders postal code field" do
    expect(rendered).to have_field("address[postal_code]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.address.postal_code"))
  end

  it "renders prefecture field" do
    expect(rendered).to have_field("address[prefecture]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.address.prefecture"))
  end

  it "renders city field" do
    expect(rendered).to have_field("address[city]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.address.city"))
  end

  it "renders street field" do
    expect(rendered).to have_field("address[street]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.address.street"))
  end

  it "renders building field" do
    expect(rendered).to have_field("address[building]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.address.building"))
  end

  it "renders country dropdown" do
    expect(rendered).to have_select("address[country]")
    expect(rendered).to have_css("label", text: I18n.t("activerecord.attributes.address.country"))
  end

  context "with validation errors" do
    before do
      allow(address).to receive(:errors).and_return({
                                                      postal_code: ["is invalid"],
                                                      prefecture: [],
                                                      city: [],
                                                      street: [],
                                                      building: [],
                                                      country: []
                                                    })

      render partial: "addresses/form", locals: { form: form, address: address }
    end

    it "applies error styling to fields with errors" do
      expect(rendered).to have_field("address[postal_code]", class: "border-red-400")
    end
  end
end
