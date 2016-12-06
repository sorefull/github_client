Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:index]
  get 'users/:username', to: 'users#show', as: 'user'

  resources :repos, only: [:index]
  get 'repos/:reponame', to: 'repos#show', as: 'repo'

  get '', to: 'repos#show', as: 'welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
