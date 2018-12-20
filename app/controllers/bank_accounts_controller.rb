class BankAccountsController < ApplicationController
  def index
    @bank_accounts = BankAccount.all
  end

  def new
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)

    if @bank_account.save
      flash[:success] = "Bank Account successfully created"
      redirect_to bank_account_path(@bank_account.id)
    else
      render "new"
    end
  end

  def edit
    @bank_account = BankAccount.find(params[:id])
  end

  def update
    @bank_account = BankAccount.find(params[:id])

    if @bank_account.update(bank_account_params)
      flash[:warning] = "Account has been updated"
      redirect_to bank_account_path(@bank_account.id)
    else
      render "edit"
    end
  end

  def destroy
    bank_account = BankAccount.find(params[:id])
    client = bank_account.client

    if bank_account.balance > 0
      flash[:danger] = "Cannot delete an account with a balance"
      redirect_to bank_account_path(bank_account.id)
    else
      bank_account.destroy!
      flash[:danger] = "Account has successfully been deleted"
      redirect_to client_path(client)
    end
  end

  def show
    @bank_account = BankAccount.find(params[:id])
  end

  private

  def bank_account_params
    params.require(:bank_account).permit(:account_number, :client_id)
  end
end