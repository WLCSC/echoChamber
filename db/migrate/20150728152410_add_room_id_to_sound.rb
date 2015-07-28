class AddRoomIdToSound < ActiveRecord::Migration
  def change
    add_reference :sounds, :room, index: true, foreign_key: true
  end
end
