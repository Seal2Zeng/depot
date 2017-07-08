Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users
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
