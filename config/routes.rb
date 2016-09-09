Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'ipn/new'

 devise_for :users,  path_names: { sign_in: 'welcome', sign_up: 'register' }, controllers: { sessions: 'users/sessions',  omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
 devise_scope :user do
   get 'users/login', to: 'users/sessions#login', as: 'custom_login_page'
 end

 resources :credits, only: :create
 resources :games do
   member do
     get 'summary'
     post 'process_bet'
     post 'determine_winner'
   end
 end

 get '/dashboard', to: 'home#dashboard'
 get '/wallet', to: 'home#wallet'
 root 'home#index'
end
