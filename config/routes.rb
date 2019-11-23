Rails.application.routes.draw do
  root to: 'toppages#index'

    get 'search', to: 'products#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  delete 'delete', to: 'users#destroy'

  delete 'leave', to: 'admin/users#destroy'

  get 'form', to: 'products#new', as:'form'

  get 'products/:id', to: 'products#show'
  patch 'products/:id', to: 'products#update'
  get 'products/:id/edit', to: 'products#edit'

  get 'buy', to: 'users#index'

  get 'edit', to: 'users#show'

  get 'exhibition/:id', to: 'users#exhibition', as:'exhibition'

  get 'problem/:id', to: 'users#problem', as:'problem'

  # get 'microposts/:id', to: 'users#microposts', as:'microposts'

  # get 'micropost/:id', to: 'users#microposts', as:'micropost'

   # to: 'microposts#destroy'

  # get 'micropost/:id', to:'users#microposts'
  # post 'micropost/:id', to:'users#microposts', as:'micropost'

  # patch 'microposts/:id', to: 'microposts#destroy'



  get 'twitter', to:'microposts#index'

  get 'microposts/:id', to:'users#tweets', as:'microposts'

  post 'posttweets', to:'microposts#create'

  post '/products/:product_id/likes' => "favorites#create"
  delete '/products/:product_id/likes' => "favorites#destroy"

  get 'like' , to: 'users#likes'

  get 'signup', to: 'users#new'

  get 'searching', to: 'posts#index'

  get 'search', to: 'products#index'

  get 'reviewed', to: 'users#reviewed', as:'reviewed'

  get 'post', to: 'posts#new'

  get 'postsearching', to: 'microposts#index'

  patch 'cancel', to: 'products#cancel', as:'cancel'

  get 'good', to: 'users#good', as:'good'

  get 'normal', to: 'users#normal'

  get 'bad', to: 'users#bad'

  get 'leave', to: 'admin/users#index'


  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index ,:new, :star]

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :products, only: [:index, :show, :create, :new, :destroy, :edit, :update]

   resources :notifications, only: :index

  resources :posts

  resources :products do
    member do
      get :purchase
    end
  end

  resources :users do
    member do
      get :likes
      get :evaluates
      get :microposts
      # get :good
    end
  end

  # scope "(:locale)" do
	# resources :notifications
  # resources :paginate
  # end

  resources :favorites, only: [:create, :destroy]

  resources :reviews, only: [:new, :show, :create, :update]

  resources :microposts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  namespace :admin do
   resources :users, only: [:index, :destroy]
 end


end
