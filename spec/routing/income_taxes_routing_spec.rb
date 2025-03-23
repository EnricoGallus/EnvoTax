# frozen_string_literal: true

require "rails_helper"

RSpec.describe IncomeTaxesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/income_taxes").to route_to("income_taxes#index")
    end

    it "routes to #new" do
      expect(get: "/income_taxes/new").to route_to("income_taxes#new")
    end

    it "routes to #show" do
      expect(get: "/income_taxes/1").to route_to("income_taxes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/income_taxes/1/edit").to route_to("income_taxes#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/income_taxes").to route_to("income_taxes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/income_taxes/1").to route_to("income_taxes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/income_taxes/1").to route_to("income_taxes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/income_taxes/1").to route_to("income_taxes#destroy", id: "1")
    end
  end
end
