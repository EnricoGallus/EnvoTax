# frozen_string_literal: true

# controller for saving user data
class UsersController < ApplicationController
  def edit
    @user = current_user
    @user.build_address unless @user.address
    @user.build_bank_account unless @user.bank_account
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to root_path, notice: t("users.successfully_updated")
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.expect(user: [:name,
                         { address_attributes:
                             [:id, :postal_code, :prefecture, :city, :street, :building, :country] },
                         { bank_account_attributes:
                             [:id, :account_holder, :bank_name, :branch_code, :account_number, :account_type] }])
  end
end
