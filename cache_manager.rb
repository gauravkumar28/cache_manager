
class CacheManager
  attr_accessor :cache, :policy

  def initialize(cache=nil, policy=nil)
    @cache = cache || Cache.new(5, 24*60*60)
    @policy = policy || EvictionPolicy.new()
  end

  def get(key)
    @cache.get(key)
  end

  def set(key, value, ttl=nil)
    @cache.set(key, value, ttl)
  end

  def expires

  end

  def del key
    @cache.del(key)
  end

  def values
    @cache.values
  end

  def keys
    @cache.keys
  end

end