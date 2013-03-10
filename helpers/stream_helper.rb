helpers do

  def update_stream(stream_uri, cache)
    info = Stream::Service.normalize(stream_uri)
    case info[:service]
    when :twitch || :justin
      str = Stream::Twitch.new(stream_uri, {update: false})
    when :hashd
      str = Stream::Hashd.new(stream_uri, {update: false})
    end

    if object = cache.get(str.cache_id)
      return Stream.from_yaml(object.value)
    else
      str.update
      cache.put(str.cache_id, str.to_yaml)
      Stream.from_yaml(cache.get(str.cache_id).value)
    end
  end

  def build_url(service, stream_id)
    case service
    when :twitch
      "http://twitch.tv/#{stream_id}"
    when :hashd
      "http://hashd.tv/#{stream_id}"
    end
  end

end
