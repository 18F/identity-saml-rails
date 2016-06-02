Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
