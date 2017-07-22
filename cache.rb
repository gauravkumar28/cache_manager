class Cache
  attr_accessor :data, :max_size, :available_size, :policy, :data_ttl
  

  def initialize(max_size=nil, ttl=nil, policy=nil)
    @data = {}
    @max_size = max_size || 10
    @ttl = ttl || 1.day
    @policy = policy || EvictionPolicy.new()
    @data_ttl = []
  end

  def max_size
    @max_size || 10
  end

  def ttl
    @ttl || 1.day
  end

  def data
    @data
  end
  
  def policy
    @policy
  end

  def has_space?
    @data.size < max_size
  end
  
  def get key
    val_obj = @data[key]
    unless val_obj.nil?
      new_index = @policy.update(@data_ttl, key, val_obj.index) 
      @data[key].index = new_index
      return val_obj.val
    end
    nil
  end

  def set(key, value, ttl=nil)
    ttl ||= @ttl 
    del(key) #REMOVE DUPLICATE KEY
    if(has_space?)
      @data[key] =  ValObj.new(value, ttl)
      @data_ttl = @policy.add(@data_ttl, key)
    else
      ele_to_evict = @policy.selectedBasedOnPolicy(@data_ttl)
      @data.delete(ele_to_evict)
      @data[key] = ValObj.new(value, ttl)
      @data_ttl = @policy.add(@data_ttl, key)
    end
    @data[key].index = @data_ttl.length - 1
  end

  def size
    @data.size
  end

  def clear
    @data.clear
  end

  def values
    @data.values
  end

  def keys
    @data.keys
  end

  def del key
    return if @data[key].nil?
    index = @data[key].index
    @data.delete(key)
    @data_ttl.delete_at(index)
  end

end