Rails.application.routes.draw do
  #get 'pages/home'
  root "pages#index"

  resources :members
  get '/products', to: 'products#index'
   get '/products/new', to: 'products#new'
   post '/products', to: 'products#create'
   get '/products/:id/edit', to: 'products#edit'
   patch '/products/:id', to: 'products#update', as: 'edit_product'
   get '/products/:id', to: 'products#show'
   delete '/products/:id', to: 'products#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

end
