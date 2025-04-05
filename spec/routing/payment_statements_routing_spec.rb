# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentStatementsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/payment_statements").to route_to("payment_statements#index")
    end

    it "routes to #new" do
      expect(get: "/payment_statements/new").to route_to("payment_statements#new")
    end

    it "routes to #show" do
      expect(get: "/payment_statements/1").to route_to("payment_statements#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/payment_statements/1/edit").to route_to("payment_statements#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/payment_statements").to route_to("payment_statements#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/payment_statements/1").to route_to("payment_statements#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/payment_statements/1").to route_to("payment_statements#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/payment_statements/1").to route_to("payment_statements#destroy", id: "1")
    end
  end
end
