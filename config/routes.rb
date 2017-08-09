Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations',  }
  post '/signup' => 'splash#signup', as: :splash_signup
  get '/splash' => 'splash#index'
  get '/dynamic_forms' => 'dynamic_forms#index'
  get '/dynamic_forms/builder' => 'dynamic_forms#builder'
  post '/dynamic_forms/preserve_form_data' => 'dynamic_forms#preserve_form_data'
  root 'dynamic_forms#builder'
  get '/setup' => 'setup#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
