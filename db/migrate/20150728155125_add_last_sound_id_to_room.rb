class AddLastSoundIdToRoom < ActiveRecord::Migration
  def change
    add_reference :rooms, :last_sound, index: true, foreign_key: true
  end
end
