class Stream

	class Twitch < Stream
		StreamJsonUri = 'http://api.justin.tv/api/stream/list.json?channel='

		private

		def build(data)
			# Twitch puts the stream data in an array, move it up
			data = data[0]

			if data
				@is_live = true
				@name    = data['title']
				@viewers = data['channel_count']
				@uri     = data['channel']['channel_url']
			else
				@is_live = false
				@name    = nil
				@viewers = 0
				@uri     = nil
			end
		end

	end

end
