# frozen_string_literal: true

require "rails_helper"

RSpec.describe "projects/new", type: :view do
  before do
    assign(:project, Project.new)
    assign(:clients, [create(:client)])
    render
  end

  it "renders new project form" do
    assert_form_elements
  end

  def assert_form_elements
    assert_select "form[action=?][method=?]", projects_path, "post" do
      assert_select "input[name=?]", "project[name]"
      assert_select "select[name=?]", "project[client_id]"
      assert_select "input[name=?]", "project[hourly_rate]"
    end
  end
end
