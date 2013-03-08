require 'digest/md5'

class ObjectCache

  def initialize(cache)
    @cache = cache
  end

  def get(object, ttl = settings.cache_ttl)
    if @cache.fetch(key(object)) == nil
      return nil
    end
    @cache.fetch(key(object))
  end

  def set(object, value, ttl = settings.cache_ttl)
    @cache.set(key(object), value, ttl)
  end

  private

  def key(object)
    Digest::MD5.hexdigest(object)
  end

end
