Rails.application.routes.draw do

  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  resources :books do
    resources :ratings
  end


  resources :ratings

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#destroy'
  delete "/signout", to: "sessions#destroy"

  get '/auth/facebook/callback' => 'sessions#create'



end
