# frozen_string_literal: true

# bank account model
class BankAccount < ApplicationRecord
  belongs_to :accountable, polymorphic: true

  enum :account_type, { ordinary: 0, savings: 1 }

  validates :account_holder, presence: true
  validates :bank_name, presence: true
  validates :branch_code, presence: true, format: { with: /\A\d+\z/ }
  validates :account_number, presence: true, format: { with: /\A\d+\z/ }
end
