Rails.application.routes.draw do
  
  get 'artists', to: 'artists#index'
  get 'artists/:id_artist', to: 'artists#show', constraints: { id_artist: /[^\/]+/ }
  post 'artists', to: 'artists#create'
  delete 'artists/:id_artist', to: 'artists#delete', constraints: { id_artist: /[^\/]+/ }
  
  get 'albums', to: 'albums#index'
  get 'albums/:id_album', to: 'albums#show', constraints: { id_album: /[^\/]+/ }
  post 'artists/:id_artist/albums', to: 'albums#create', constraints: { id_artist: /[^\/]+/ }
  delete 'albums/:id_album', to: 'albums#delete', constraints: { id_album: /[^\/]+/ }

  get 'tracks', to: 'tracks#index'
  get 'tracks/:id_track', to: 'tracks#show', constraints: { id_track: /[^\/]+/ }
  post 'albums/:id_album/tracks', to: 'tracks#create', constraints: { id_album: /[^\/]+/ }
  delete 'tracks/:id_track', to: 'tracks#delete', constraints: { id_track: /[^\/]+/ }
  
  root to: 'artists#index'

end
