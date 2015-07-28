class AddAttachmentDataToSounds < ActiveRecord::Migration
  def self.up
    change_table :sounds do |t|
      t.attachment :data
    end
  end

  def self.down
    remove_attachment :sounds, :data
  end
end
