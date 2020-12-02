module Enumerable
  def my_each
    x = 0
    while x < length
      yield(self[x])
      x += 1
    end
  end  
end