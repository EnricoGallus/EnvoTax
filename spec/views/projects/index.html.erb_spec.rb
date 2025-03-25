# frozen_string_literal: true

require "rails_helper"

RSpec.describe "projects/index", type: :view do
  let(:project_list) { create_list(:project, 2) }

  before do
    assign(:projects, project_list)
    render
  end

  it "renders a list of projects" do
    assert_select "#projects" do
      assert_select "table tbody tr[id]", count: 2 do |elements|
        elements.each_with_index { |element, index| assert_project_details(element, project_list[index]) }
      end
    end
  end

  def assert_project_details(element, project)
    assert_select element, "td", text: project.name, count: 1
    assert_select element, "td" do
      assert_select "a.btn.btn-primary", text: /Show/
      assert_select "a.btn.btn-primary", text: /Edit/
      assert_select "form button.btn.btn-error", text: /Delete/
    end
  end
end
