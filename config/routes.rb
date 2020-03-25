Rails.application.routes.draw do
  resources :diffs
  resources :reviews
  resources :repositories

  get :select_repository, to: 'select_repository#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'repositories#index'
end
