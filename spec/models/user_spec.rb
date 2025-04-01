# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "associations" do
    it { is_expected.to have_one(:address).dependent(:destroy) }
    it { is_expected.to have_one(:bank_account).dependent(:destroy) }
    it { is_expected.to have_many(:payment_adjustments).dependent(:destroy) }
    it { is_expected.to have_many(:payment_statements).dependent(:destroy) }
  end

  describe "nested attributes" do
    it { is_expected.to accept_nested_attributes_for(:address).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:bank_account).allow_destroy(true) }
  end

  describe "concerns" do
    describe "addressable behavior" do
      it "can build an address" do
        user = build(:user)
        expect(user.build_address).to be_an(Address)
      end
    end

    describe "accountable behavior" do
      it "can build a bank account" do
        user = build(:user)
        expect(user.build_bank_account).to be_a(BankAccount)
      end
    end
  end

  describe "factory" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end
  end
end
