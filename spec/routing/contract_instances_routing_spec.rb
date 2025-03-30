# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContractInstancesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/contract_instances").to route_to("contract_instances#index")
    end

    it "routes to #new" do
      expect(get: "/contract_instances/new").to route_to("contract_instances#new")
    end

    it "routes to #show" do
      expect(get: "/contract_instances/1").to route_to("contract_instances#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/contract_instances/1/edit").to route_to("contract_instances#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/contract_instances").to route_to("contract_instances#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/contract_instances/1").to route_to("contract_instances#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/contract_instances/1").to route_to("contract_instances#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/contract_instances/1").to route_to("contract_instances#destroy", id: "1")
    end
  end
end
