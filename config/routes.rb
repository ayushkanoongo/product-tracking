Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products do
  	member do
  		get 'received'
  		get 'received_return'
  	end
  	collection do
  		get 'create_received_return'
  	end
  end

  # get 'products/:id/return', to: 'products#return'
end
