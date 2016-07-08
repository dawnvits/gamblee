Rails.application.routes.draw do
 devise_for :users, controllers: { sessions: 'users/sessions' }
 devise_scope :user do
   get 'users/login', to: 'users/sessions#login', as: 'custom_login_page'
 end

 root 'home#index'
end
