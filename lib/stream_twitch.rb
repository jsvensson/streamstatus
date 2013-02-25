class Stream

	class Twitch < Stream

		private

		def build(data)
			# Twitch puts the stream data in an array, move it up
			data = data[0]
			@json_uri = "http://api.justin.tv/api/stream/list.json?channel=#{@stream_id}"
      @username = @stream_id.downcase
			if data
        @is_live  = true
        @title    = data['title']
        @viewers  = data['channel_count']
        @game     = data['meta_game']
			else
        @is_live = false
        @title   = "Offline Twitch/Justin stream"
        @viewers = 0
			end
		end

	end

end
