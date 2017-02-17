Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'posts#index'

  resources :posts do
    resources :likes, only: [:create, :destroy], defaults: {:likeable => "Post"}
    resources :comments, defaults: { commentable: "Post"}
  end

  resources :comments do
    resources :likes, only: [:create, :destroy], defaults: {:likeable => "Comment"}
  end

  resources :users do
    resource :profile, only: [:edit, :update, :show]
    resources :pictures, except: [:edit, :update] do
      resources :likes, only: [:create, :destroy], defaults: {:likeable => "Picture"}
      resources :comments, defaults: { commentable: "Picture"}
    end
    get :search_users, :on => :collection

    member do
      get "accept_friend"
      get "request_friend"
      get "delete_friend"
      get "reject_friend"
    end
  end

  resources :likes, only: [:destroy]
  resources :pictures, only: [:destroy]

  # resources :pictures, only: [:show]

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    get "log_in", to: "devise/sessions#new"
    delete "sign_out", to: "devise/sessions#destroy"
    delete "log_out", to: "devise/sessions#destroy"
  end

  resources :friendings, :only => [:create, :destroy]
end
