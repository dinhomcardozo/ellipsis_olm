class ClientsController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard] # Autenticação do client ou user
  before_action :authenticate_system_admin!, only: [:dashboard] # Autenticação do system_admin
  before_action :set_client, only: [:show, :edit, :update, :destroy, :dashboard]
  load_and_authorize_resource

  def dashboard
    # Código para mostrar o dashboard do Client/ User
  end

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end
  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  private
  
  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, :system_admin_id)
  end
end