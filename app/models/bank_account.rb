# frozen_string_literal: true

# bank account model
class BankAccount < ApplicationRecord
  belongs_to :accountable, polymorphic: true

  validates :account_holder, presence: true
  validates :bank_name, presence: true
  validates :branch_code, presence: true, format: { with: /\A\d{3}\z/ }
  validates :account_number, presence: true, format: { with: /\A\d{7}\z/ }
end
