class HomeController < ApplicationController
  def index
    if current_system_admin # Verifique se é um SystemAdmin logado
      redirect_to system_admin_dashboard_path # Defina o caminho do dashboard do admin
    elsif current_user # Verifique se é um Client/User logado
      redirect_to dashboard_client_path(current_user.client_id) # Defina o caminho do dashboard do cliente
    else
      # Caso não esteja logado
      redirect_to new_user_session_path # Redirecione para a página de login
    end
  end
end