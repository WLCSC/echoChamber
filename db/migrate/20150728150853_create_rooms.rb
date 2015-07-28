class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :last_file_id, index: true, foreign_key: true
      t.string :password
      t.text :comment
      t.string :user_sid
      t.string :name

      t.timestamps null: false
    end
  end
end
