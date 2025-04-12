# frozen_string_literal: true

# model for the user information
class User < ApplicationRecord
  include Accountable
  include AddressableConcern

  has_many :invoices, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :cost_types, dependent: :destroy

  validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :payment_adjustments, dependent: :destroy
  has_many :payment_statements, dependent: :destroy
end
