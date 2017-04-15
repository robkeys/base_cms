Rails.application.routes.draw do

  # establish resourceful routes for all CRUD actions
  resources :pages do
    member do
      get :delete
    end
  end

  # establish resourceful routes for all CRUD actions
  resources :subjects do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
