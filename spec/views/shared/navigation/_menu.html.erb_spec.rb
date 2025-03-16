# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shared/navigation/_menu.html.erb", type: :view do
  describe "when rendering menu" do
    before do
      render
      rendered.gsub!("<details>", "<details open>")
    end

    it "has a menu for clients" do
      expect(rendered).to have_link("Clients", href: clients_path)
    end

    it "has a menu for projects" do
      expect(rendered).to have_link("Projects", href: projects_path)
    end
  end
end
