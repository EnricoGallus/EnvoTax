# frozen_string_literal: true

# concern for address
module AddressableConcern
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :address, allow_destroy: true
  end

  def build_address(attributes = {})
    super
  end
end
