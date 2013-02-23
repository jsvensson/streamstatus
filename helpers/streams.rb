helpers do

  def update_stream(stream_uri)
    logger.info "Setting up cache"
    cache = ObjectCache.new(settings.cache)

    logger.debug "Creating Stream object"
    str = Stream::Twitch.new(stream_uri, {update: false})
    logger.debug "Created #{str}"

    logger.debug "Checking cache for #{str}..."
    if object = cache.get(str.cache_id)
      logger.debug "--> exists in cache, returning cached object"
      return object
    else
      logger.debug "--> not in cache"
      logger.debug "Updating #{str}"
      str.update
      logger.debug "Caching #{str.username}"
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
