Rails.application.routes.draw do
  get 'ipn/new'

 devise_for :users,  path_names: { sign_in: 'welcome', sign_up: 'register' }, controllers: { sessions: 'users/sessions',  omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
 devise_scope :user do
   get 'users/login', to: 'users/sessions#login', as: 'custom_login_page'
 end

 resources :games do
   member do
     get 'summary'
     post 'process_bet'
     post 'determine_winner'
   end
 end

 resources :credits, only: :create

 get '/dashboard', to: 'home#dashboard'
 root 'home#index'
end
