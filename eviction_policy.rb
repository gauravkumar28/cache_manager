class EvictionPolicy
  
  attr_accessor :name
  
  def initialize(name = nil)
    @name = name || "default eviction policy"
  end

  def selectedBasedOnPolicy(data)
    data.shift[:key]
  end

  def compare(obj1, obj2)
  end

  def add(data, key)
    data.push({key: key, property: 1})
  end

  def update(data, key, index)
    return index if index == 0
    data[index][:property] += 1
    data_update = data[index - 1 ]
    data[index - 1 ] = data[index]
    data[index] = data_update
    index - 1
  end
end