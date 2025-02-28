module TurboStreams
  module ToastHelper
    def toast(text, type: 'notice', duration: 3000, gravity: 'top', position: 'center', close: true)
      turbo_stream_action_tag(:toast, type:, text:, duration:, gravity:, position:, close:)
    end
  end
end