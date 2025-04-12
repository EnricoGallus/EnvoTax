# frozen_string_literal: true

# allows to set pundit policies in view specs
module PunditSpecHelper
  def enable_pundit(view, user)
    without_partial_double_verification do
      allow(view).to receive(:policy) do |record|
        Pundit.policy(user, record)
      end
    end
  end
end
