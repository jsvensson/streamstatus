require 'httparty'

class Stream

	attr_reader :name, :viewers, :uri

	StreamJsonUri = {
		own3d: "http://api.own3d.tv/rest/live/status.json?liveid=",
		twitch: "http://api.justin.tv/api/stream/list.json?channel="
	}

	def initialize(stream_id, service = :own3d, options = {})
		@options = options
		@service = service
		@stream_id = stream_id

		if @options[:file]
			@json_uri = @options[:file]
		else
			@json_uri = StreamJsonUri[@service] + @stream_id.to_s
		end

		get_status
	end

	def is_live?
		@is_live
	end

	private

	def get_status
		if @options[:file]
			f = File.read(@json_uri)
			response = MultiJson.load(f)
		else
			response = HTTParty.get(@json_uri)
		end

		case @service
		when :twitch
			@response = build_twitch(response)
		when :own3d
			@response = build_own3d(response)
		end
	end

	def build_twitch(data)
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

	def build_own3d(data)
		@is_live = data['live_is_live'].to_i == 1
		@name    = data['live_name']
		@viewers = data['live_viewers'].to_i
		@uri     = "http://www.own3d.tv/#{data['channel_name']}/live/#{data['live_id']}"
	end

end
