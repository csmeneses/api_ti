Rails.application.routes.draw do
  get 'artists', to: 'artists#index', as: 'artists_index'
  get 'artists/:id_artist', to: 'artists#show', as: 'artist_show'
  post 'artists', to: 'artists#create', as: 'artist_create'
  
  root to: 'artists#index'

end
