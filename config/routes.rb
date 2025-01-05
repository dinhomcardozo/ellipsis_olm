Rails.application.routes.draw do
  get "groups/index"
  get "groups/show"
  get "groups/new"
  get "groups/create"
  get "groups/edit"
  get "groups/update"
  get "groups/destroy"
  get "companies/index"
  get "companies/show"
  get "companies/new"
  get "companies/create"
  get "companies/edit"
  get "companies/update"
  get "companies/destroy"
  get "clients/index"
  get "clients/show"
  get "clients/new"
  get "clients/create"
  get "clients/edit"
  get "clients/update"
  get "clients/destroy"
  # Rotas padrões para grupos de recursos
  resources :group_companies
  resources :group_clients
  resources :contract_client_products
  resources :client_users
  resources :client_products
  resources :users
  resources :channels
  resources :tax_regimes
  resources :system_admins
  resources :sub_segments
  resources :stages
  resources :segments
  resources :product_brands
  resources :contracts
  resources :opportunities
  resources :plans
  resources :clients_products
  resources :groups
  resources :contacts
  resources :companies

  # Rotas para Devise
  devise_for :users, path: 'users', path_names: { sign_in: 'login', sign_out: 'logout' }
  devise_for :system_admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout' }

  # Rotas de SystemAdmins
  resources :system_admins, only: [] do
    collection do
      get 'dashboard'
    end
  end

  # Rotas de Clients
  resources :clients do
    member do
      get 'dashboard', to: 'clients#dashboard', as: :dashboard
    end
    resources :users
    resources :opportunities, only: [:index, :show]
  end

  # Rotas de Stages
  resources :stages do
    resources :opportunities, only: [:index]
  end

  # Health check da aplicação
  get "up", to: "rails/health#show", as: :rails_health_check

  # Root da aplicação
  root 'home#index'
end