class JukeboxController < FayeRails::Controller
	# Create a channel for each room.
	Room.all.each do |r|
		channel "/echochamber/#{r.id}" do
			monitor :subscribe do
				Rails.logger.debug "Client #{client_id} subscribed to #{channel}."
			end
			monitor :publish do
				Rails.logger.debug "Client #{client_id} published #{data.inspect} to #{channel}."
			end
    	end
	end
end
