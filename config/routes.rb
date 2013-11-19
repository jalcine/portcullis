Portcullis::Application.routes.draw do
  root to: 'home#landing'
  get '/about', to: 'home#about', as: :about
  get '/about/tos', to: 'home#tos', as: :terms_of_service
  get '/privacy-policy', to: 'home#privacy_policy', as: :privacy_policy

  devise_for :users, path: '/', module: 'users', format: false,
    path_names: {
    sign_in: :login,
    sign_out: :logout,
    sign_up: :join,
    password: :secret,
    registration: '',
    sessions: ''
  }, controllers: { omniauth_callbacks: 'users/omniauth' }

  get '/u/:id',       to: 'users/profiles#view', as: :view_profile
  get '/u/edit',      to: 'users/profiles#edit', as: :edit_profile
  put '/u/edit',      to: 'users/profiles#update'
  get '/u/dashboard', to: 'users/profiles#new', as: :view_user_dashboard

  resources :events
  resources :tickets

  match '*a', to: 'home#rescue_from_routing_error', via: [:get, :post, :patch, :put, :delete] if Rails.env.production?
end
