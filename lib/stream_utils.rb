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
      hashd: "http://api.hashd.tv/v1/stream/"
    }

    def self.normalize(url)
      patterns = [
        /http:\/\/(?:www.)?(justin|twitch).tv\/(\w+)/,  # Justin/Twitch
        /http:\/\/(?:www.)?(hashd).tv\/(\w+)/           # Hashd
      ]

      for pattern in patterns do
        if url =~ pattern
          service = $1.to_sym
          stream_id = $2
          result = {
            service: service,
            stream_id: stream_id,
            cache_id: Stream::Cache.name(service, stream_id),
            json_uri: "#{StreamJsonUri[service]}#{stream_id}"
          }
          return result
          break
        end
      end
      raise RegexpError, "Couldn't match URL to any pattern: #{url}"
    end

    def self.get_uri
    end

  end

end
