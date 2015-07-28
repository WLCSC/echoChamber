class AddLastFileIdToRoom < ActiveRecord::Migration
  def change
    add_reference :rooms, :last_file, index: true, foreign_key: true
  end
end
