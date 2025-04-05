# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaymentAdjustmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/payment_adjustments").to route_to("payment_adjustments#index")
    end

    it "routes to #new" do
      expect(get: "/payment_adjustments/new").to route_to("payment_adjustments#new")
    end

    it "routes to #show" do
      expect(get: "/payment_adjustments/1").to route_to("payment_adjustments#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/payment_adjustments/1/edit").to route_to("payment_adjustments#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/payment_adjustments").to route_to("payment_adjustments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/payment_adjustments/1").to route_to("payment_adjustments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/payment_adjustments/1").to route_to("payment_adjustments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/payment_adjustments/1").to route_to("payment_adjustments#destroy", id: "1")
    end
  end
end
