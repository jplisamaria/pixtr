Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"
  resources :galleries do
    resources :images, only: [:new, :create]
  end

  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]
  end

  resources :groups, only: [:index, :new, :create, :show]

  
  resources :users, only: [:show] do
    member do # /users/:id
      post "follow" => "following_relationships#create" # /users/:id/follow
      delete "unfollow" => "following_relationships#destroy"
    end
  end



end
