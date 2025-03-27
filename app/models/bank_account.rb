# frozen_string_literal: true

# bank account model
class BankAccount < ApplicationRecord
  belongs_to :accountable, polymorphic: true
end
