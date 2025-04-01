# frozen_string_literal: true

# concern for address
module Addressable
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :address, allow_destroy: true
  end
end
