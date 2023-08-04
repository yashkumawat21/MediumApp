Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/login', to: 'auth#login'
  resources :users, only: [:create, :index, :show]

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :topics, only: [:index, :create, :show]
  # config/routes.rb
  resources :follows, only: [:create, :destroy]




  

  
  # Additional custom routes for filtering
  get '/posts/filter', to: 'posts#index'

  # Route for searching posts by author, topic, or content
  get '/posts/search/forpost', to: 'posts#search'

  # Additional routes for editing and deleting posts
  put '/posts/:id', to: 'posts#update'
  delete '/posts/:id', to: 'posts#destroy'
end
