Rails.application.routes.draw do

  root :to => 'public#index'

  # Public area routes
  get 'show/:permalink', :to => 'public#show', :as => 'public_show'

  # Use simple routes for access/account stuff since this is not based on DB
  get 'admin', :to => 'access#menu'
  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  # establish resourceful routes for all Sections CRUD actions
  resources :sections do
    member do
      get :delete
    end
  end

  # establish resourceful routes for all Pages CRUD actions
  resources :pages do
    member do
      get :delete
    end
  end

  # establish resourceful routes for all Subjects CRUD actions
  resources :subjects do
    member do
      get :delete
    end
  end

  # establish resourceful routes for all Users CRUD actions
  resources :users, :except => [:show] do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
