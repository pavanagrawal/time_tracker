Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations',  }
  post '/signup' => 'splash#signup', as: :splash_signup
  get '/splash' => 'splash#index'
  get '/splash/get_timesheet_atom' => 'splash#get_timesheet_atom'
  put '/splash/post_timesheet' => 'splash#post_timesheet'
  root 'splash#index'
  get 'reports' => 'reports#index'
  get '/setup' => 'setup#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
