require 'rubygems'
require 'bundler/setup'
require 'httparty'

class StreamStatus

	@@stream_uri = {
		own3d: "http://api.own3d.tv/rest/live/status.json?liveid=",
		twitch: "http://api.justin.tv/api/stream/list.json?channel="
	}

	def initialize(stream_id, service = :own3d)
		@service = service
		@stream_id = stream_id
		@stream_uri = @@stream_uri[@service] + @stream_id.to_s
		get_status
	end

	def is_live?
		case @service
		when :own3d
			@response['live_is_live'].to_i == 1
		when :twitch
			@response["format"] == "live"
		end
	end

	def name
		case @service
		when :own3d
			@response["live_name"]
		when :twitch
			@response["name"]
		end

	end

	def viewers
		case @service
		when :own3d
			@response["live_viewers"].to_i
		when :twitch
			@response["channel_count"]
		end
	end

	private

	def get_status
		puts "## Stream URI: #{@stream_uri}"
		puts "## Getting JSON for #{@service.capitalize} stream #{@stream_id}"
		@response = HTTParty.get(@stream_uri)

		# Cleanup for Twitch
		case @service
		when :twitch
			@response = @response[0]
		end
	end

end
