require 'digest/md5'

class ObjectCache

  def initialize(client, cache)
    @cache = client.cache(cache)
  end

  def get(object)
    if @cache.get(key(object)) == nil
      return nil
    end
    @cache.get(key(object))
  end

  def put(object, value, ttl = settings.cache_ttl)
    @cache.put(key(object), value, {expires_in: ttl})
  end

  private

  def key(object)
    Digest::MD5.hexdigest(object)
  end

end
