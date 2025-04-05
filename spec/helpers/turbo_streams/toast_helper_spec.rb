# frozen_string_literal: true

require "rails_helper"

RSpec.describe TurboStreams::ToastHelper, type: :helper do
  describe "#toast" do
    it "returns a turbo_stream_action_tag with default values" do
      toast_message = "Test message"
      result = helper.toast(toast_message)

      expect(result).to be_a(String)
      expect(result).to include("turbo-stream ")
      expect(result).to include('type="notice"')
      expect(result).to include('text="Test message"')
      expect(result).to include('duration="3000"')
      expect(result).to include('gravity="top"')
      expect(result).to include('position="center"')
      expect(result).to include('close="true"')
    end

    it "accepts custom type parameter" do
      result = helper.toast("Error occurred", type: "error")
      expect(result).to include('type="error"')
    end

    it "accepts custom duration option" do
      result = helper.toast("Quick message", options: { duration: 1000 })
      expect(result).to include('duration="1000"')
    end

    it "accepts custom gravity option" do
      result = helper.toast("Bottom message", options: { gravity: "bottom" })
      expect(result).to include('gravity="bottom"')
    end

    it "accepts custom position option" do
      result = helper.toast("Left message", options: { position: "left" })
      expect(result).to include('position="left"')
    end

    it "accepts close option" do
      result = helper.toast("No close button", options: { close: false })
      expect(result).to include('close="false"')
    end

    it "handles multiple custom options simultaneously" do
      result = helper.toast(
        "Custom toast",
        type: "warning",
        options: {
          duration: 5000,
          gravity: "bottom",
          position: "right",
          close: false
        }
      )

      expect(result).to include('type="warning"')
      expect(result).to include('duration="5000"')
      expect(result).to include('gravity="bottom"')
      expect(result).to include('position="right"')
      expect(result).to include('close="false"')
    end
  end
end
