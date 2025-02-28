# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/new" do
  before do
    assign(:client, Client.new(
                      name: "MyString",
                      currency: "MyString",
                      address: nil
                    ))
  end

  it "renders new client form" do
    render

    assert_select "form[action=?][method=?]", clients_path, "post" do
      assert_select "input[name=?]", "client[name]"

      assert_select "input[name=?]", "client[currency]"

      assert_select "input[name=?]", "client[address_id]"
    end
  end
end
