Rails.application.routes.draw do
  root 'home#index'
  get 'success', to: 'home#success'
  get 'failure', to: 'home#failure'

  post 'auth/:provider/callback', to: 'sessions#create'
end
