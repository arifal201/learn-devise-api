Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      get 'products', to: 'products#index'
      get 'products/:id', to: 'products#show'
      post 'products', to: 'products#create'
      patch 'products/:id', to: 'products#update'
      delete 'products/:id', to: 'products#destroy'

      get 'invoices', to: 'invoices#index'
      post 'invoices', to: 'invoices#create'
      get 'invoices/:id', to: 'invoices#show'
      patch 'invoices/:id', to: 'invoices#update'
      delete 'invoices/:id', to: 'invoices#destroy'
      get 'users/invoices', to: 'invoices#user_invoices'
      get 'users/invoices/:id', to: 'invoices#user_invoice_detail'
    end
  end
end
