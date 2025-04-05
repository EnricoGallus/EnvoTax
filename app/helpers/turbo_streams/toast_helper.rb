# frozen_string_literal: true

module TurboStreams
  # Helper methods for toast messages
  module ToastHelper
    def toast(text, type: "notice", options: {})
      duration = options.fetch(:duration, 3000)
      gravity = options.fetch(:gravity, "top")
      position = options.fetch(:position, "center")
      close = options.fetch(:close, true)
      turbo_stream_action_tag(:toast, type:, text:, duration:, gravity:, position:, close:)
    end
  end
end
