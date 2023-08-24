Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/constellations', to: "constellations#index"
  get '/constellations/:id', to: "constellations#show"
  
  get '/stars', to: "stars#index"
end
