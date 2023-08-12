Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      
      # Add other API routes here
       # root "articles#index"
  post '/login', to: 'auth#login'
  root 'posts#index'

  resources :users, only: [:show , :create , :index] do
    member do
      post 'follow'
      delete 'unfollow'
    end
  end
  get 'posts/:post_id/getversions', to: 'posts#previousversions'
  post 'change_subscription/:subscription_id', to: 'users#change_subscription', as: :change_subscription
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :topics, only: [:index, :create, :show]
  # config/routes.rb
  resources :follows, only: [:create, :destroy]

 





  get 'topposts', to: 'posts#topposts'

  get 'drafts', to: 'posts#getdrafts'

  post 'posts/:id/saved', to: 'posts#save_post_for_later'
  get 'posts/:id/saved_posts', to: 'posts#get_saved_posts'
  # Additional custom routes for filtering
  get '/posts/filter', to: 'posts#index'

  get 'recommendbytopic' , to: 'posts#recommendbytopic'
  get 'recommendbyauthor' , to: 'posts#recommendbyauthor'

  # Route for searching posts by author, topic, or content
  get '/posts/search/forpost', to: 'posts#search'

  # Additional routes for editing and deleting posts
  put '/posts/:id', to: 'posts#update'
  delete '/posts/:id', to: 'posts#destroy'

  resources :lists, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  
  end
  post 'lists/:list_id/add_post/:post_id', to: 'lists#add_post'
  post 'lists/:list_id/create_share/:user_id', to: 'lists#create_share'
  get 'lists/:user_id/shared_list', to: 'lists#shared_lists'
  
  post 'create_payment', to: 'payments#create_payment'
 
  # Defines the root path route ("/")

end
end

end
