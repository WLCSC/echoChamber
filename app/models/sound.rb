class Sound < ActiveRecord::Base
	belongs_to :room

	has_attached_file :data

	validates_attachment :data, content_type: { content_type: "audio/mpeg" }
end
