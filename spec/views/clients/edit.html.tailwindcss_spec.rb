# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/edit" do
  let(:client) do
    Client.create!(
      name: "MyString",
      currency: "MyString",
      address: nil
    )
  end

  before do
    assign(:client, client)
  end

  it "renders the edit client form" do
    render

    assert_select "form[action=?][method=?]", client_path(client), "post" do
      assert_select "input[name=?]", "client[name]"

      assert_select "input[name=?]", "client[currency]"

      assert_select "input[name=?]", "client[address_id]"
    end
  end
end
