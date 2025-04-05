# frozen_string_literal: true

require "rails_helper"

RSpec.describe CostTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cost_types").to route_to("cost_types#index")
    end

    it "routes to #new" do
      expect(get: "/cost_types/new").to route_to("cost_types#new")
    end

    it "routes to #show" do
      expect(get: "/cost_types/1").to route_to("cost_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/cost_types/1/edit").to route_to("cost_types#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/cost_types").to route_to("cost_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/cost_types/1").to route_to("cost_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/cost_types/1").to route_to("cost_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/cost_types/1").to route_to("cost_types#destroy", id: "1")
    end
  end
end
