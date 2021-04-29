class TracksController < ApplicationController
  @@base_url = 'https://polar-tundra-13798.herokuapp.com'
  def index
    @tracks = Track.all
    response = []
    @tracks.each do |track|
      response << track.generate_response(@@base_url)
    end
    render json: response, status: :ok
  end

  def show
    id_track = params[:id_track]
    @track = Track.where(id_track: id_track)
    if !@track.empty?
      @track = @track[0]
      response = @track.generate_response(@@base_url)
      render json: response, status: :ok
    else
      render json: { "error": 'track not found' }, status: :not_found
    end
  end

  def create
    id_album = params[:id_album]
    track_params = params.require(:track).permit(:name, :duration)
    track_params[:times_played] = 0
    enc = Base64.encode64("#{track_params[:name]}:#{id_album}")
    track_params[:id_track] = enc.gsub("\n", '').truncate(22)

    # Revisar si existe album
    album_ok = true
    album = Album.where(id_album: id_album)
    if album.empty?
      album_ok = false
    end

    # Revisar si existe track
    no_conflict = true
    existing_track = Track.where(id_track: track_params[:id_track])
    if !existing_track.empty?
      no_conflict = false
    end

    if album_ok && no_conflict
      @track = Track.new(track_params)
      @track.save
      album[0].tracks << @track
      render json: @track.generate_response(@@base_url), status: :created
    elsif !album_ok
      render json: { "error": 'album does not exist' }, status: :unprocessable_entity
    elsif !no_conflict
      @track = existing_track[0]
      render json: @track.generate_response(@@base_url), status: :conflict
    end
  end

  def delete
    id_track = params[:id_track]
    @track = Track.where(id_track: id_track)
    if !@track.empty?
      @track[0].destroy
      render json: { "success": 'track deleted' }, status: :no_content
    else
      render json: { "error": 'track not found' }, status: :not_found
    end
  end
end
