Rails.application.routes.draw do
  root 'employees#index'
  resources :policies
  resources :companies
  resources :employees do
    collection do
      post :import
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
