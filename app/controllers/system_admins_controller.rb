class SystemAdminsController < ApplicationController
  before_action :authenticate_system_admin! # Autenticação do admin
  load_and_authorize_resource # from app/models/ability.rb

  def dashboard
      # Código para mostrar o dashboard do SystemAdmin
  end

  def index
      @system_admins = SystemAdmin.all
  end

  def show
      @system_admin = SystemAdmin.find(params[:id])
  end

  def new
      @system_admin = SystemAdmin.new
  end

  def create
      @system_admin = SystemAdmin.new(system_admin_params)
      if @system_admin.save
          redirect_to @system_admin, notice: 'SystemAdmin was successfully created.'
      else
          render :new
      end
  end

  def edit
      @system_admin = SystemAdmin.find(params[:id])
  end

  def update
      @system_admin = SystemAdmin.find(params[:id])
      if @system_admin.update(system_admin_params)
          redirect_to @system_admin, notice: 'SystemAdmin was successfully updated.'
      else
          render :edit
      end
  end

  def destroy
      @system_admin = SystemAdmin.find(params[:id])
      @system_admin.destroy
      redirect_to system_admins_url, notice: 'SystemAdmin was successfully destroyed.'
  end

  private
      def system_admin_params
          params.require(:system_admin).permit(:name, :email)
      end
end