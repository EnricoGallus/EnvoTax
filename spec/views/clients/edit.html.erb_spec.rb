# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/edit.html.erb", type: :view do
  let(:client) { create(:client) }

  before do
    assign(:client, client)
    render
  end

  it "renders the edit client form" do
    assert_form_elements
  end

  def assert_form_elements
    assert_select "form[action=?][method=?]", client_path(client), "post" do
      assert_select "input[name=?]", "client[name]"
      assert_select "select[name=?]", "client[currency]"
      assert_select "input[name=?]", "client[address_attributes][id]"
      assert_select "input[name=?]", "client[address_attributes][postal_code]"
    end
  end
end
