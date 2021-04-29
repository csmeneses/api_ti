class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  
  def generate_response(base_url)
    response = {
      "name": name,
      "age": age,
      "albums": "#{base_url}/artists/#{id_artist}/albums",
      "tracks": "#{base_url}/artists/#{id_artist}/tracks",
      "self": "#{base_url}/artists/#{id_artist}"
    }
    response
  end
end
