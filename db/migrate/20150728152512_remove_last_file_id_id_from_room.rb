class RemoveLastFileIdIdFromRoom < ActiveRecord::Migration
  def change
    remove_reference :rooms, :last_file_id, index: true, foreign_key: true
  end
end
