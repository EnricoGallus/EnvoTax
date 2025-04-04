# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/new.html.erb", type: :view do
  before do
    client = Client.new
    client.build_address
    assign(:client, client)
    render
  end

  it "renders new client form" do
    assert_form_elements
  end

  def assert_form_elements
    assert_select "form[action=?][method=?]", clients_path, "post" do
      assert_select "input[name=?]", "client[name]"
      assert_select "input[name=?]", "client[hourly_rate]"
      assert_select "input[name=?]", "client[address_attributes][postal_code]"
    end
  end
end
