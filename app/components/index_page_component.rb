# frozen_string_literal: true

class IndexPageComponent < ViewComponent::Base
  def initialize(title:, content_title:, model_name:, new_path:, new_text:, collection:)
    @title = title
    @content_title = content_title
    @model_name = model_name
    @new_path = new_path
    @new_text = new_text
    @collection = collection
  end
end
