class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :id_track
      t.string :id_album
      t.string :name
      t.float :duration
      t.integer :times_played
      t.string :artist
      t.string :album
      t.string :self

      t.timestamps
    end
  end
end
