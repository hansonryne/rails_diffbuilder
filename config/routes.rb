Rails.application.routes.draw do
  resources :greps
  resources :rule_tags
  resources :tags
  resources :rules
  resources :languages
  resources :diffs
  resources :reviews
  resources :repositories

  get :select_repository, to: 'select_repository#index'
  get :build_languages, to:'languages#build_languages'
  get :build_language_rules, to:'languages#build_rules_for_language'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'repositories#index'
end
