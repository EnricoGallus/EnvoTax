# frozen_string_literal: true

class DataTableComponent < ViewComponent::Base
  renders_one :headers
  renders_many :rows
  renders_one :custom_actions

  def initialize(collection:, show_path: true, edit_path: true, delete_path: true)
    @collection = collection
    @show_path = show_path
    @edit_path = edit_path
    @delete_path = delete_path
  end

  def show_actions?
    @show_path || @edit_path || @delete_path || custom_actions.present?
  end
end
