class Album < ApplicationRecord
  belongs_to :artist
  has_many :tracks, dependent: :destroy

  def generate_response(base_url)
    response = {
      "name": name,
      "genre": genre,
      "artist": "#{base_url}/artists/#{artist.id_artist}",
      "tracks": "#{base_url}/albums/#{id_album}/tracks",
      "self": "#{base_url}/albums/#{id_album}"
    }
    response
  end

end
