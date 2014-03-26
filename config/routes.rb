Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"
  resource :dashboard, only: [:show]

  resources :galleries do
    resources :images, only: [:new, :create]
    member do
      post "like" => "gallery_likes#create"
      delete "unlike" => "gallery_likes#destroy"
    end
  end

  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]
    member do
      post "like" => "image_likes#create"
      delete "unlike" => "image_likes#destroy"
    end
  end

  resources :groups, only: [:index, :new, :create, :show] do
    member do
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
      post "like" => "group_likes#create"
      delete "unlike" => "group_likes#destroy"
    end

  end

  
  resources :users, only: [:show] do
    member do # /users/:id
      post "follow" => "following_relationships#create" # /users/:id/follow
      delete "unfollow" => "following_relationships#destroy"
    end
  end
end
