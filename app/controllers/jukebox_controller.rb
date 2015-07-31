class JukeboxController < FayeRails::Controller
	# Create a channel for each room.
	Room.all.each do |r|
		channel "/echochamber/#{r.id}" do
            monitor :subscribe do
                Rails.logger.debug "Someone subscribed to #{r.name}!"
            end
    	end
	end
end
