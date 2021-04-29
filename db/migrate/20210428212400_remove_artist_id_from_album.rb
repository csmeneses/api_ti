class RemoveArtistIdFromAlbum < ActiveRecord::Migration[5.2]
  def change
    remove_column :albums, :id_artist
  end
end
