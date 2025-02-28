# frozen_string_literal: true

require "rails_helper"

RSpec.describe "clients/index" do
  before do
    assign(:clients, [
             Client.create!(
               name: "Name",
               currency: "Currency",
               address: nil
             ),
             Client.create!(
               name: "Name",
               currency: "Currency",
               address: nil
             )
           ])
  end

  it "renders a list of clients" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Name"), count: 2
    assert_select cell_selector, text: Regexp.new("Currency"), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
