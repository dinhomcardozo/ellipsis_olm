class ApplicationController < ActionController::Base
  before_action :authenticate_user!  # Para usuários/clientes

  def authenticate_system_admin!
    redirect_to root_path unless current_system_admin
  end
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

end
