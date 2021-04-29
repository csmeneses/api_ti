class AddAlbumToTracks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tracks, :album, foreign_key: true
  end
end
