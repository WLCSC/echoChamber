class Room < ActiveRecord::Base
	belongs_to :last_file_id, class_name: "Sound"

	has_many :sounds
	validates :name, :user_sid, :password, presence: true
end
