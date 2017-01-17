Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'posts/index' => 'posts#index'
  root 'posts#index'

  resources :posts, :only => [:index, :new, :create, :show]
end
