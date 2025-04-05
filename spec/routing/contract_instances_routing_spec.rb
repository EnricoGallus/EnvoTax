# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContractInstancesController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/contracts/10/contract_instances/new").to route_to(
        "contract_instances#new", contract_id: "10"
      )
    end

    it "routes to #edit" do
      expect(get: "/contracts/10/contract_instances/1/edit").to route_to(
        "contract_instances#edit", contract_id: "10", id: "1"
      )
    end

    it "routes to #create" do
      expect(post: "/contracts/10/contract_instances").to route_to(
        "contract_instances#create", contract_id: "10"
      )
    end

    it "routes to #update via PUT" do
      expect(put: "/contracts/10/contract_instances/1").to route_to(
        "contract_instances#update", contract_id: "10", id: "1"
      )
    end

    it "routes to #update via PATCH" do
      expect(patch: "/contracts/10/contract_instances/1").to route_to(
        "contract_instances#update", contract_id: "10", id: "1"
      )
    end

    it "routes to #destroy" do
      expect(delete: "/contracts/10/contract_instances/1").to route_to(
        "contract_instances#destroy", contract_id: "10", id: "1"
      )
    end
  end
end
