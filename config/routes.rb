Bloccit::Application.routes.draw do
  
  devise_for :users
  resources :users, only: [:update]

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts do
    resources :comments, only: [:create]
  end 
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
