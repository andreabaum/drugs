Rails.application.routes.draw do
  resources :purchases
  resources :drugs
  resources :consumptions
  resources :users

  root 'drugs#index'

  resources :drugs do
    resources :purchases
    resources :consumptions

    #get "/reset" => "drugs#reset"
  end
end
