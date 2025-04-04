# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentAllocationsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/payment_statements/1/payment_allocations/new").to route_to(
        "payment_allocations#new", payment_statement_id: "1"
      )
    end

    it "routes to #show" do
      expect(get: "/payment_statements/1/payment_allocations/1").to route_to(
        "payment_allocations#show", id: "1", payment_statement_id: "1"
      )
    end

    it "routes to #edit" do
      expect(get: "/payment_statements/1/payment_allocations/1/edit").to route_to(
        "payment_allocations#edit", id: "1", payment_statement_id: "1"
      )
    end

    it "routes to #create" do
      expect(post: "/payment_statements/1/payment_allocations").to route_to(
        "payment_allocations#create", payment_statement_id: "1"
      )
    end

    it "routes to #update via PUT" do
      expect(put: "/payment_statements/1/payment_allocations/1").to route_to(
        "payment_allocations#update", id: "1", payment_statement_id: "1"
      )
    end

    it "routes to #update via PATCH" do
      expect(patch: "/payment_statements/1/payment_allocations/1").to route_to(
        "payment_allocations#update", id: "1", payment_statement_id: "1"
      )
    end

    it "routes to #destroy" do
      expect(delete: "/payment_statements/1/payment_allocations/1").to route_to(
        "payment_allocations#destroy", id: "1", payment_statement_id: "1"
      )
    end
  end
end
