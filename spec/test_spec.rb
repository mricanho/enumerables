# spec/test_spec.rb
require './main'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }
  describe '#my_each' do
    it 'Returns the same array, and print the result on each element in the array according the block' do
      expect(array.my_each { |num| num + 1 }).to eql(array)
    end

    it 'Returns the <#Enumerator: array :my_each> if no given block' do
      expect(array.my_each).to be_a(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'Returns the same array and it accesses to the index of each element ' do
      expect(array.my_each_with_index { |num, index| print "This #{num} has index number #{index}" }).to eql(array)
    end

    it 'Returns the <#Enumerator: array :my_each> if no given block' do
      expect(array.my_each_with_index).to be_a(Enumerator)
    end
  end

  describe '#my_select' do
    it 'Returns an array with the true condition in the block' do
      expect(array.my_select { |num| num > 1 }).to eql([2, 3, 4])
    end

    it 'Returns the <#Enumerator: array :my_each> if no given block' do
      expect(array.my_select).to be_a(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'Returns True if the block never returns false or nil.' do
      expect(array.my_all? { |num| num > 0 }).to eql(true)
    end

    it 'Returns false if one item returns false or nil from the given condition in the block' do
      expect(array.my_all? { |num| num < 0 }).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'Retruns true if one item returns true from the given condition in the block' do
      expect(array.my_any? { |_num| _num = 4 }).to eql(true)
    end

    it 'Returns false if all items in the array return false from the given condition in the block ' do
      expect(array.my_any? { |num| num > 4 }).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'Return true if all elements return false from the given condition in the block' do
      expect(array.my_none? { |num| num > 4 }).to eql(true)
    end

    it 'Return false if one element returns true from the given condition in the block' do
      expect(array.my_none? { |_num| _num = 4 }).to eql(false)
    end
  end

  describe '#my_count' do
    it 'Returns the total number of array elements if no argument or block are given' do
      expect(array.my_count).to eql(array.length)
    end

    it 'If an argument is given, it returns the total number of array elements that equal to an argument' do
      expect(array.my_count(2)).to eql(1)
      expect(array.my_count(5)).to eql(0)
    end

    it 'If a block, it returns the total number of array elements that return true' do
      expect(array.my_count(&:even?)).to eql(2)
      expect(array.my_count { |num| num % 3 == 0 }).to eql(1)
      expect(array.my_count { |num| num % 5 == 0 }).to eql(0)
    end
  end

  describe '#my_map' do
    it 'Returns new array with the condition in the block: Add 2 to each element of the array' do
      expect(array.my_map { |num| num + 2 }).to eql([3, 4, 5, 6])
    end

    it 'Returns the <#Enumerator: array :my_each> if no given block' do
      expect(array.my_map).to be_a(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'Returns a value according to condition in the symbol or that given in the block ' do
      expect(array.my_inject(:+)).to eql(10)
      expect(array.my_inject { |acc, num| acc + num }).to eql(10)
    end

    it 'If an argument is given, starting with argument as an accumulator' do
      expect(array.my_inject(2) { |acc, num| acc + num }).to eql(12)
    end
  end
end
