# frozen_string_literal: true

require "rails_helper"

RSpec.describe BankAccount, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:accountable) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:account_holder) }
    it { is_expected.to validate_presence_of(:bank_name) }
    it { is_expected.to validate_presence_of(:branch_code) }
    it { is_expected.to validate_presence_of(:account_number) }

    context "when validating branch_code format" do
      it { is_expected.to allow_value("123").for(:branch_code) }
      it { is_expected.to allow_value("12").for(:branch_code) }
      it { is_expected.to allow_value("1234").for(:branch_code) }
      it { is_expected.not_to allow_value("abc").for(:branch_code) }
    end

    context "when validating account_number format" do
      it { is_expected.to allow_value("1234567").for(:account_number) }
      it { is_expected.to allow_value("123456").for(:account_number) }
      it { is_expected.to allow_value("12345678").for(:account_number) }
      it { is_expected.not_to allow_value("abcdefg").for(:account_number) }
    end
  end
end
