# frozen_string_literal: true

# bank account controller
# TODO: we don't use any of the methods, only the partial form is used in client/users views
class BankAccountsController < ApplicationController
  before_action :set_accountable
  before_action :set_bank_account, only: %i[show edit update destroy]

  # GET /bank_accounts
  def index
    @q = BankAccount.ransack(params[:q])
    @bank_accounts = @q.result(distinct: true)
  end

  # GET /bank_accounts/1
  def show; end

  # GET /bank_accounts/new
  def new
    @bank_account = @accountable.build_bank_account
  end

  # GET /bank_accounts/1/edit
  def edit; end

  # POST /bank_accounts
  def create
    @bank_account = @accountable.build_bank_account(bank_account_params)

    if @bank_account.save
      redirect_to @bank_account, notice: t("bank_account.successfully_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bank_accounts/1
  def update
    if @bank_account.update(bank_account_params)
      redirect_to @bank_account, notice: t("bank_account.successfully_updated"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bank_accounts/1
  def destroy
    @bank_account.destroy!
    redirect_to bank_accounts_path, notice: t("bank_account.successfully_destroyed"), status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bank_account
    @bank_account = BankAccount.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def bank_account_params
    params.expect(bank_account: [:account_holder, :bank_name, :branch_code, :account_number, :accountable_id,
                                 :accountable_type])
  end

  def set_accountable
    @accountable = if params[:client_id]
                     Client.find(params[:client_id])
                   else
                     current_user
                   end
  end
end
