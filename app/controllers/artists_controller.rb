class ArtistsController < ApplicationController
  @@base_url = 'https://polar-tundra-13798.herokuapp.com'
  
  def index
    @artists = Artist.all
    response = []
    @artists.each do |artist|
      response << artist.generate_response(@@base_url)
    end
    render json: response, status: :ok
  end

  def show
    # Checkear inputs válidos
    id_artist = params[:id_artist]
    @artist = Artist.where(id_artist: id_artist)
    if !@artist.empty?
      @artist = @artist[0]
      response = @artist.generate_response(@@base_url)
      render json: response, status: :ok
    else
      render json: { "error": 'artist not found' }, status: :not_found
    end
  end

  def create
    artist_params = params.require(:artist).permit(:name, :age)
    
    # Revisar si viene bien el input
    #! Hay que ver si sobran y rechazar o solo ignorarlos?
    #! Si viene vacío es 404 igual
    input_ok = true
    if !artist_params.keys.include? 'name'
      input_ok = false
    elsif !artist_params[:name].is_a?(String)
      input_ok = false
    end
    if !artist_params.keys.include? 'age'
      input_ok = false
    elsif !artist_params[:age].is_a?(Integer)
      input_ok = false
    end
    
    if input_ok
      enc = Base64.encode64(artist_params[:name])
      artist_params[:id_artist] = enc.gsub("\n", '').truncate(22, omission: '')

      # Revisar si existe artist
      no_conflict = true
      existing_artist = Artist.where(id_artist: artist_params[:id_artist])
      if !existing_artist.empty?
        no_conflict = false
      end

      if no_conflict
        @artist = Artist.new(artist_params)
        @artist.save
        render json: @artist.generate_response(@@base_url), status: :created
      else
        @artist = existing_artist[0]
        render json: @artist.generate_response(@@base_url), status: :conflict
      end
    else
      render json: { "error": 'bad request' }, status: :bad_request
    end
  end

  def delete
    id_artist = params[:id_artist]
    @artist = Artist.where(id_artist: id_artist)
    if !@artist.empty?
      @artist[0].destroy
      render json: { "success": 'artist deleted' }, status: :no_content
    else
      render json: { "error": 'artist not found' }, status: :not_found
    end
  end

  def albums
    id_artist = params[:id_artist]
    artist_ok = true
    @artist = Artist.where(id_artist: id_artist)
    if @artist.empty?
      artist_ok = false
    end

    if artist_ok
      @artist = @artist[0]
      @albums = @artist.albums
      response = []
      @albums.each do |album|
        response << album.generate_response(@@base_url)
      end
      render json: response, status: :ok
    else
      render json: { "error": 'artist not found' }, status: :not_found
    end
  end

  def tracks
    id_artist = params[:id_artist]
    artist_ok = true
    @artist = Artist.where(id_artist: id_artist)
    if @artist.empty?
      artist_ok = false
    end

    if artist_ok
      @artist = @artist[0]
      albums = @artist.albums
      response = []
      albums.each do |album|
        album.tracks.each do |track|
          response << track.generate_response(@@base_url)
        end
      end
      render json: response, status: :ok
    else
      render json: { "error": 'artist not found' }, status: :not_found
    end
  end

  def play
    id_artist = params[:id_artist]
    @artist = Artist.where(id_artist: id_artist)
    artist_ok = true
    if @artist.empty?
      artist_ok = false
    end

    if artist_ok
      @artist = @artist[0]
      @artist.listen
      render json: { "success": 'artist played' }, status: :ok
    else
      render json: { "error": 'artist not found' }, status: :not_found
    end
  end

  def error
    render json: { "error": 'method not allowed' }, status: :method_not_allowed
  end
end
