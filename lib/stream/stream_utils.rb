class Stream

	module Cache

		def self.name(*args)
			Digest::MD5.hexdigest args.join('-')
		end

	end

	module Service

		StreamJsonUri = {
			twitch: "http://api.justin.tv/api/stream/list.json?channel=",
			justin: "http://api.justin.tv/api/stream/list.json?channel=",
			own3d: "http://api.own3d.tv/rest/live/status.json?liveid="
		}

		def self.normalize(url)
			patterns = [
				/http:\/\/www.(own3d).tv\/\w+\/live\/(\d+)/,  # Own3d
				/http:\/\/www.(justin|twitch).tv\/(\w+)/  # Justin/Twitch
			]

			for pattern in patterns do
				if url =~ pattern
					service = $1.to_sym
					stream_id = $2
					result = {
						service: service,
						stream_id: stream_id,
						cache_id: Digest::MD5.hexdigest("#{service}-#{stream_id}"),
						json_uri: "#{StreamJsonUri[service]}#{stream_id}"
					}
					return result
					break
				end
			end
			raise RegexpError, "Couldn't match URL to any pattern"
		end

		def self.get_uri
		end

	end

end
