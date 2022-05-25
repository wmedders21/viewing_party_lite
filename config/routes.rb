Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'landing#dashboard'
  get '/dashboard', to: 'users#dashboard'
  get '/dashboard/discover', to: 'users#discover'
  get '/register', to: 'registration#dashboard'
  post '/users', to: 'users#create'
  get '/dashboard/movies', to: 'users#results'
  get '/dashboard/movies/:id', to: 'users#details'
  get 'dashboard/movies/:id/viewing-party/new', to: 'parties#new'
  post 'dashboard/movies/:id/viewing-party/new', to: 'parties#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
