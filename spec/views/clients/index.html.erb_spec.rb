# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/index.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:client_list) { create_list(:client, 2, user: user) }

  before do
    assign(:clients, client_list)
    enable_pundit(view, user)
    render
  end

  it "renders a table of clients" do
    assert_select "#clients" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_client_details(element, client_list[index]) }
      end
    end
  end

  private

  def assert_client_details(element, client)
    assert_select element, "td", text: client.name, count: 1
    assert_select element, "td", text: client.hourly_rate.format, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-accent", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
