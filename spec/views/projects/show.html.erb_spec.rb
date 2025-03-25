# frozen_string_literal: true

require "rails_helper"

RSpec.describe "projects/show", type: :view do
  before do
    assign(:project, create(:project))
    render
  end

  it "renders name" do
    expect(rendered).to match(/Name/)
  end
end
