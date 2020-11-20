# frozen_string_literal: true

Rails.application.routes.draw do
  resources :line_items
  resources :carts
  # as 'store_index' means we can use 'store_index_path' and 'store_index_url'
  root "store#index", as: "store_index"
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
