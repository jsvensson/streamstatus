class Stream

	class Twitch < Stream
		StreamJsonUri = 'http://api.justin.tv/api/stream/list.json?channel='

		private

		def build(data)
			# Twitch puts the stream data in an array, move it up
			data = data[0]
			@json_uri   = "http://api.justin.tv/api/stream/list.json?channel=#{@stream_id}"
			if data
				@is_live    = true
				@name       = data['title']
				@viewers    = data['channel_count']
				@stream_uri = data['channel']['channel_url']
			else
				@is_live    = false
				@name       = nil
				@viewers    = 0
				@stream_uri = nil
			end
		end

	end

end
