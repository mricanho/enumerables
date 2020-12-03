# rubocop: disable Style/CaseEquality
module Enumerable
  UNDEFINED = Object.new
  def my_each
    return to_enum(:my_each) unless block_given?

    x = 0
    while x < to_a.length
      yield to_a[x]
      x += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |x| result << x if yield(x) }
    result
  end

  def my_all?(arg = UNDEFINED)
    unless block_given?
      if arg != UNDEFINED
        my_each { |x| return false unless arg === x }
      else
        my_each { |x| return false unless x }
      end
      return true
    end
    my_each { |i| return false unless yield(i) }
    true
  end

  def my_any?(arg = UNDEFINED, &block)
    unless block_given?
      if arg != UNDEFINED
        my_each { |x| return true if arg === x }
      else
        my_each { |x| return true if x }
      end
      return false
    end
    my_each { |i| return true if block.call(i) }
    false
  end

  def my_none?(arg = UNDEFINED, &block)
    !my_any?(arg, &block)
  end

  def my_count(arg = UNDEFINED)
    count = 0
    if block_given?
      to_a.my_each { |x| count += 1 if yield(x) }
    elsif !block_given? && arg.nil?
      count = to_a.length
    else
      count = to_a.my_select { |x| x == arg }.length
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?

    arr = []
    if proc.nil?
      to_a.my_each { |item| arr << yield(item) }
    else
      to_a.my_each { |item| arr << proc.call(item) }
    end
    arr
  end

  def my_inject(*arg)
    new_array = to_a
    total = arg[0]
    if arg[0].instance_of?(Symbol)
      total = new_array[0]
      new_array = new_array[1..-1]
      new_array.my_each { |x| total = total.send(arg[0], x) }
    elsif arg[0].class < Numeric && arg[1].class != Symbol
      new_array.my_each { |x| total = yield(total, x) }
    elsif arg[0].class < Numeric && arg[1].instance_of?(Symbol)
      new_array.my_each { |x| total = total.send(arg[1], x) }
    else
      total = new_array[0]
      new_array = new_array[1..-1]
      new_array.my_each { |x| total = yield(total, x) }
    end
    total
  end
end

# rubocop: enable Style/CaseEquality

def multiply_els(arg)
  arg.my_inject(:*)
end
