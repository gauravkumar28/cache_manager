Dir[File.dirname(__FILE__) + "/*.rb"].each do |file|
  require file
end

module CacheManagerTesting
  class << self
    def testDefaultCahce
      cache_manager = CacheManager.new()
      
      puts cache_manager.set(1, "2")
      puts cache_manager.get(1)
      puts cahce_manager.del(1)
      puts cahce_manager.get(1)
    end
  end
end