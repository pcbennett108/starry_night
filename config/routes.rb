Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "constellations#home"
  get '/constellations', to: "constellations#index"
  get '/constellations/new', to: "constellations#new"
  get '/constellations/:id', to: "constellations#show"
  post '/constellations', to: "constellations#create"
  get '/constellations/:id/edit', to: "constellations#edit"
  patch '/constellations/:id', to: "constellations#update"
  
  get '/constellations/:const_id/stars', to: "constellation_stars#index"
  get '/constellations/:const_id/stars/new', to: "constellation_stars#new"
  post '/constellations/:const_id/stars', to: "constellation_stars#create"
  
  get '/stars', to: "stars#index"
  get '/stars/:id', to: "stars#show"
  get '/stars/:id/edit', to: "stars#edit"
  patch '/stars/:id', to: "stars#update"
end
