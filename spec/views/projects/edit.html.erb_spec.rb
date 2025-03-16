# frozen_string_literal: true

require "rails_helper"

RSpec.describe "projects/edit", type: :view do
  let(:project) { create(:project) }

  before do
    assign(:project, project)
    assign(:clients, [project.client])
    render
  end

  it "renders the edit project form" do
    assert_form_elements
  end

  def assert_form_elements
    assert_select "form[action=?][method=?]", project_path(project), "post" do
      assert_select "input[name=?]", "project[name]"
      assert_select "select[name=?]", "project[client_id]"
      assert_select "input[name=?]", "project[hourly_rate]"
    end
  end
end
