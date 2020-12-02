module Enumerable
  def my_each
    x = 0
    while x < length
      yield(self[x])
      x += 1
    end
  end  
  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end
end