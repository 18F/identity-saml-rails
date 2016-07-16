Rails.application.routes.draw do
  root 'home#index'
  get 'success', to: 'home#success'
  get 'failure', to: 'home#failure'

  post 'auth/:provider/callback', to: 'sessions#create'
  post 'auth/:provider/logout', to: 'sessions#destroy'
  delete 'auth/:provider/logout', to: 'sessions#destroy'
  match 'auth/:provider/setup', to: 'sessions#setup', via: [:get, :post]
end
