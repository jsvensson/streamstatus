class Stream

	class Own3d < Stream

		private

		def build(data)
			@is_live    = data['live_is_live'].to_i == 1
			@name       = data['live_name']
			@viewers    = data['live_viewers'].to_i
			@json_uri   = "http://api.own3d.tv/rest/live/status.json?liveid=#{@stream_id}"
		end

	end

end
