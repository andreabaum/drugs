Rails.application.routes.draw do
  resources :purchases
  resources :drugs
  resources :consumptions
  resources :users
  resources :events

  root 'drugs#index'

  resources :drugs do
    resources :purchases
    resources :consumptions

    #get "/reset" => "drugs#reset"
  end
end
