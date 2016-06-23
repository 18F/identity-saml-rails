Rails.application.routes.draw do
  root 'home#index'
  get 'success', to: 'home#success'

  post 'auth/:provider/callback', to: 'sessions#create'
end
