class Sound < ActiveRecord::Base
	has_attached_file :data

	validates_attachment :data, content_type: { content_type: "audio/mpeg" }
end
