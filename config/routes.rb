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

  get '/search', to: 'search#present', as: :search

  post '/tinymce_assets', to: 'tinymce_assets#create'

  get '/u/:id',       to: 'users/profiles#view', as: :view_profile
  get '/u/edit',      to: 'users/profiles#edit', as: :edit_profile
  put '/u/edit',      to: 'users/profiles#update'

  resources :events do
    resources :tickets
  end

  resources :orders

  #match '/vanity/:action/:id', controller: :vanity, via: [:get, :post, :patch, :put, :delete]
end
