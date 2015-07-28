class Room < ActiveRecord::Base
	belongs_to :last_file_id, class_name: "Sound"
end
