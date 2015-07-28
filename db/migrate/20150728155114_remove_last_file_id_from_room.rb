class RemoveLastFileIdFromRoom < ActiveRecord::Migration
  def change
    remove_reference :rooms, :last_file, index: true, foreign_key: true
  end
end
