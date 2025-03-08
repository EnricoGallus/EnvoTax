# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/index.html.erb", type: :view do
  before do
    assign(:clients, create_list(:client, 2))
    render
  end

  it "renders a list of clients" do
    assert_select "#clients" do
      assert_select "div.flex.justify-between.items-center", count: 2 do |elements|
        elements.each { |element| assert_client_details(element) }
      end
    end
  end

  def assert_client_details(element)
    assert_select element, "div>strong", text: "Name:", count: 1
    assert_select element, "div>strong", text: "Currency:", count: 1
    assert_select element, "div>strong", text: "Address:", count: 1
  end
end
