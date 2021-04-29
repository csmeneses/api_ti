class RemoveIdAlbumFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :id_album
  end
end
