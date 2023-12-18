Rails.application.routes.draw do
  root 'movies#search'
  get '/search', to: 'movies#search'
end