Rails.application.routes.draw do

  # Wrong method handling
  put 'artists', to: 'artists#error'
  put 'artists/:id_artist', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  put 'artists/:id_artist/albums', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  put 'artists/:id_artist/tracks', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  put 'albums', to: 'albums#error'
  put 'albums/:id_album', to: 'albums#error', constraints: { id_album: /[^\/]+/ }
  put 'albums/:id_album/tracks', to: 'albums#error', constraints: { id_album: /[^\/]+/ }
  put 'tracks', to: 'tracks#error'
  put 'tracks/:id_track', to: 'tracks#error', constraints: { id_track: /[^\/]+/ }

  delete 'artists', to: 'artists#error'
  delete 'albums', to: 'albums#error'
  delete 'tracks', to: 'tracks#error'
  delete 'artists/:id_artist/albums', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  delete 'artists/:id_artist/tracks', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  delete 'artists/:id_artist/albums/play', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  delete 'albums/:id_album/tracks', to: 'albums#error', constraints: { id_album: /[^\/]+/ }
  delete 'albums/:id_album/tracks/play', to: 'albums#error', constraints: { id_album: /[^\/]+/ }
  delete 'tracks/:id_track/play', to: 'tracks#error', constraints: { id_track: /[^\/]+/ }

  post 'artists/:id_artist', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  post 'artists/:id_artist/tracks', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  post 'artists/:id_artist/albums/play', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  post 'albums', to: 'albums#error'
  post 'albums/:id_album', to: 'albums#error', constraints: { id_album: /[^\/]+/ }
  post 'albums/:id_album/tracks/play', to: 'albums#error', constraints: { id_album: /[^\/]+/ }
  post 'tracks', to: 'tracks#error'
  post 'tracks/:id_track', to: 'tracks#error', constraints: { id_track: /[^\/]+/ }
  post 'tracks/:id_track/play', to: 'tracks#error', constraints: { id_track: /[^\/]+/ }

  get 'artists/:id_artist/albums/play', to: 'artists#error', constraints: { id_artist: /[^\/]+/ }
  get 'albums/:id_album/tracks/play', to: 'albums#error', constraints: { id_album: /[^\/]+/ }
  get 'tracks/:id_track/play', to: 'tracks#error', constraints: { id_track: /[^\/]+/ }

  # Main
  get 'artists', to: 'artists#index'
  get 'artists/:id_artist', to: 'artists#show', constraints: { id_artist: /[^\/]+/ }
  post 'artists', to: 'artists#create'
  delete 'artists/:id_artist', to: 'artists#delete', constraints: { id_artist: /[^\/]+/ }
  get 'artists/:id_artist/albums', to: 'artists#albums', constraints: { id_artist: /[^\/]+/ }
  get 'artists/:id_artist/tracks', to: 'artists#tracks', constraints: { id_artist: /[^\/]+/ }
  put 'artists/:id_artist/albums/play', to: 'artists#play', constraints: { id_artist: /[^\/]+/ }
  
  get 'albums', to: 'albums#index'
  get 'albums/:id_album', to: 'albums#show', constraints: { id_album: /[^\/]+/ }
  post 'artists/:id_artist/albums', to: 'albums#create', constraints: { id_artist: /[^\/]+/ }
  delete 'albums/:id_album', to: 'albums#delete', constraints: { id_album: /[^\/]+/ }
  get 'albums/:id_album/tracks', to: 'albums#tracks', constraints: { id_album: /[^\/]+/ }
  put 'albums/:id_album/tracks/play', to: 'albums#play', constraints: { id_album: /[^\/]+/ }

  get 'tracks', to: 'tracks#index'
  get 'tracks/:id_track', to: 'tracks#show', constraints: { id_track: /[^\/]+/ }
  post 'albums/:id_album/tracks', to: 'tracks#create', constraints: { id_album: /[^\/]+/ }
  delete 'tracks/:id_track', to: 'tracks#delete', constraints: { id_track: /[^\/]+/ }
  put 'tracks/:id_track/play', to: 'tracks#play', constraints: { id_track: /[^\/]+/ }
  
  root to: 'artists#index'
end
