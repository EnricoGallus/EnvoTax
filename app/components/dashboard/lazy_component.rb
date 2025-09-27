# frozen_string_literal: true

module Dashboard
  # A component that loads another component lazily via Turbo Frames.
  class LazyComponent < ViewComponent::Base
    def initialize(id:, path:)
      super()
      @id = id
      @path = path
    end
  end
end
