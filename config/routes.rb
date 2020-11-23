Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products do
  	member do
  		get 'received'
		get 'received_return'
		get 'return_items'
		
  	end
	  collection do
		get 'exchange'
		get 'create_received_return'
		delete 'destroy_item'
  	end
  end

  # get 'products/:id/return', to: 'products#return'
end
