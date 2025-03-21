# frozen_string_literal: true

require "rails_helper"

RSpec.describe "invoices/index", type: :view do
  before do
    assign(:invoices, [
             Invoice.create!(
               client: nil,
               user: nil,
               status: 2
             ),
             Invoice.create!(
               client: nil,
               user: nil,
               status: 2
             )
           ])
  end

  it "renders a list of invoices" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
