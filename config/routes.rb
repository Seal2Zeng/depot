Rails.application.routes.draw do
  resources :pay_types
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'

  resources :line_items do
    post :decrease, on: :member
  end
  
  resources :orders do
    post :ship, on: :member
  end

  resources :products do
    get :who_bought, on: :member
  end

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
