class Stream

	class Twitch < Stream

		private

		def build(data)
			# Twitch puts the stream data in an array, move it up
			data = data[0]
			@json_uri   = "http://api.justin.tv/api/stream/list.json?channel=#{@stream_id}"
			if data
				@is_live    = true
				@viewers    = data['channel_count']
        @title    = data['title']
        @username = data['name']
			else
				@is_live    = false
				@viewers    = 0
        @title   = "Offline Twitch/Justin stream"
			end
		end

	end

end
