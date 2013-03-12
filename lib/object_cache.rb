class ObjectCache

  def initialize(client, cache, ttl)
    @cache = client.cache(cache)
    @ttl = ttl
  end

  def get(object)
    if @cache.get(object) == nil
      return nil
    end
    @cache.get(object)
  end

  def put(object, value, ttl = @ttl)
    @cache.put(object, value, {expires_in: ttl})
  end

end
