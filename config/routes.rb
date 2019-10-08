Rails.application.routes.draw do
  resources :posts do
  	collection do
  		get '/search'=>'posts#search'
  	end
  end

  devise_for :users
  resources :snippet_uploads
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'snippet_uploads#index'

end
