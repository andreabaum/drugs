Rails.application.routes.draw do
  resources :purchases
  resources :drugs
  resources :consumptions

  root 'drugs#index'

  resources :drugs do
    resources :purchases
    resources :consumptions
  end
end
