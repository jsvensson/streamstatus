helpers do

  def update_stream(stream_uri, cache)
    str = Stream::Twitch.new(stream_uri, {update: false})

    if object = cache.get(str.cache_id)
      return object
    else
      str.update
      cache.set(str.cache_id, str)
      cache.get(str.cache_id)
    end
  end

  def build_stream_url(service, stream_id)
    case service
    when :twitch
      "http://www.twitch.tv/#{stream_id}"
    when :justin
      "http://www.justin.tv/#{stream_id}"
    end
  end

end
