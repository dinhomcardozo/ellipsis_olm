class Ability
  include CanCan::Ability

  def initialize(user)
    if user.system_admin?
      can :manage, :all  # SystemAdmin pode acessar tudo
    elsif user.client_user?
      can :read, :all  # Client users podem apenas visualizar
      can :manage, [Group, Contact, Opportunity] # Client users gerenciam apenas seus próprios recursos
    end
  end
end