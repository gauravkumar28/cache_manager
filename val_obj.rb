class ValObj
  attr_accessor :val, :ttl, :index
  def initialize(val=nil, ttl=nil)
    @val = val || raise("Val not found")
    @ttl = ttl || 1.day
    @index = nil
  end
end