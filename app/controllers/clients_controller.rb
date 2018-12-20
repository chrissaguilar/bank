class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:success] = "Bank Account successfully created"
      redirect_to client_path(@client.id)
    else
      render "new"
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update(client_params)
      flash[:warning] = "Account has been updated"
      redirect_to client_path(@client.id)
    else
      render "edit"
    end
  end

  def destroy
    @client = Client.find(params[:id])
    if @client.balance > 0
      flash[:danger] = "Cannot delete an account with a balance"
      redirect_to client_path
    else
      @client.destroy!
      flash[:danger] = "Account has successfully been deleted"
      redirect_to clients_path
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:client_number, :first_name, :middle_name, :last_name)
  end
end