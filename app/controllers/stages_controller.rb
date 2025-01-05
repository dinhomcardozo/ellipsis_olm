class StagesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:edit, :update, :destroy]

  def index
    @stages = Stage.all
  end

  def edit
    @stage = Stage.find(params[:id])
  end

  def update
    @stage = Stage.find(params[:id])
    if @stage.update(stage_params)
      redirect_to stages_path, notice: 'Estágio atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @stage = Stage.find(params[:id])
    @stage.destroy
    redirect_to stages_path, notice: 'Estágio excluído com sucesso.'
  end

  private

  def stage_params
    params.require(:stage).permit(:description, :position, :active)
  end

  def check_admin
    # Verifica se o usuário logado é um SystemAdmin
    unless current_user.system_admin?
      redirect_to stages_path, alert: 'Você não tem permissão para fazer isso.'
    end
  end
end