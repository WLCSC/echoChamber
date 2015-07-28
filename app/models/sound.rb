class Sound < ActiveRecord::Base
	has_attached_file :data

	validates :data, attachment_content_type: "audio/mpeg"
end
