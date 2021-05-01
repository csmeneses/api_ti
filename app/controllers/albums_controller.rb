class AlbumsController < ApplicationController
  @@base_url = 'https://polar-tundra-13798.herokuapp.com'
  def index
    @albums = Album.all
    response = []
    @albums.each do |album|
      response << album.generate_response(@@base_url)
    end
    render json: response, status: :ok
  end

  def show
    id_album = params[:id_album]
    @album = Album.where(id_album: id_album)
    if !@album.empty?
      @album = @album[0]
      response = @album.generate_response(@@base_url)
      render json: response, status: :ok
    else
      render json: { "error": 'album not found' }, status: :not_found
    end
  end

  def create
    id_artist = params[:id_artist]
    album_params = params.require(:album).permit(:name, :genre)
    
    input_ok = true
    if !album_params.keys.include? 'name'
      input_ok = false
    elsif !album_params[:name].is_a?(String)
      input_ok = false
    end
    if !album_params.keys.include? 'genre'
      input_ok = false
    elsif !album_params[:genre].is_a?(String)
      input_ok = false
    end
    
    if input_ok
      enc = Base64.encode64("#{album_params[:name]}:#{id_artist}")
      album_params[:id_album] = enc.gsub("\n", '').truncate(22, omission: '')

      # Revisar si existe artist
      artist_ok = true
      artist = Artist.where(id_artist: id_artist)
      if artist.empty?
        artist_ok = false
      end

      # Revisar si existe album
      no_conflict = true
      existing_album = Album.where(id_album: album_params[:id_album])
      if !existing_album.empty?
        no_conflict = false
      end

      if artist_ok && no_conflict
        @album = Album.new(album_params)
        @album.save
        artist[0].albums << @album
        render json: @album.generate_response(@@base_url), status: :created
      elsif !artist_ok
        render json: { "error": 'artist does not exist' }, status: :unprocessable_entity
      elsif !no_conflict
        @album = existing_album[0]
        render json: @album.generate_response(@@base_url), status: :conflict
      end
    else
      render json: { "error": 'bad request' }, status: :bad_request
    end
    
  end

  def delete
    id_album = params[:id_album]
    @album = Album.where(id_album: id_album)
    if !@album.empty?
      @album[0].destroy
      render json: { "success": 'album deleted' }, status: :no_content
    else
      render json: { "error": 'album not found' }, status: :not_found
    end
  end

  def tracks
    id_album = params[:id_album]
    album_ok = true
    @album = Album.where(id_album: id_album)
    if @album.empty?
      album_ok = false
    end

    if album_ok
      @album = @album[0]
      @tracks = @album.tracks
      response = []
      @tracks.each do |track|
        response << track.generate_response(@@base_url)
      end
      render json: response, status: :ok
    else
      render json: { "error": 'album not found' }, status: :not_found
    end
  end

  def play
    id_album = params[:id_album]
    @album = Album.where(id_album: id_album)
    album_ok = true
    if @album.empty?
      album_ok = false
    end

    if album_ok
      @album = @album[0]
      @album.listen
      render json: { "success": 'album played' }, status: :ok
    else
      render json: { "error": 'album not found' }, status: :not_found
    end
  end
  def error
    render json: { "error": 'method not allowed' }, status: :method_not_allowed
  end
end
