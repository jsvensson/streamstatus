class ObjectCache

  def initialize(client, cache)
    @cache = client.cache(cache)
  end

  def get(object)
    if @cache.get(object) == nil
      return nil
    end
    @cache.get(object)
  end

  def put(object, value, ttl = settings.cache_ttl)
    @cache.put(object, value, {expires_in: ttl})
  end

end
