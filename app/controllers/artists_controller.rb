class ArtistsController < ApplicationController
  def index
    @artistas = Artist.all
    render json: @artistas
  end

  def show
    @artista = Artist.find(params[:id_artist])
  end

  def create
    # @artist = Artist.new(params)
    render json: params["artist"], status: :created
  end
end
