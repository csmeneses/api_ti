class Track < ApplicationRecord
  belongs_to :album

  def generate_response(base_url)
    response = {
      "name": name,
      "duration": duration,
      "times_played": times_played,
      "artist": "#{base_url}/artists/#{album.artist.id_artist}",
      "album": "#{base_url}/albums/#{album.id_album}",
      "self": "#{base_url}/tracks/#{id_track}"
    }
    response
  end
end
