Rails.application.routes.draw do
  get 'welcome/index'
  post 'tweets/guess'
  get 'tweets/lose'

  root 'tweets#index'

  resources :tweets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
