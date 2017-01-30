Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'posts/index' => 'posts#index'
  root :to => 'posts#index'

  resources :posts do
    resources :likes, only: [:create, :destroy], defaults: {:likeable => "Post"}
    resources :comments, defaults: { commentable: "Post"} do
      resources :likes, only: [:create, :destroy], defaults: {:likeable => "Comment"}
    end
  end

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    get "log_in", to: "devise/sessions#new"
    delete "sign_out", to: "devise/sessions#destroy"
    delete "log_out", to: "devise/sessions#destroy"

  end
end
