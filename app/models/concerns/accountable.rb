# frozen_string_literal: true

# concern for bank account
module Accountable
  extend ActiveSupport::Concern

  included do
    has_one :bank_account, as: :accountable, dependent: :destroy
    accepts_nested_attributes_for :bank_account, allow_destroy: true, reject_if: :all_blank
  end
end
