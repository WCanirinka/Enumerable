# frozen_string_literal: false

module Enumerable
  def my_each(array)
    num = []
    x = 0
    while x < array.length
      num << yield(array[x])
      x += 1
    end
    num
  end

  def my_each_with_index(array)
    num = []
    x = 0
    while x < array.length
      num << yield(array[x], x)
      x += 1
    end
    num
  end

  def my_select(array)
    num = []
    x = 0
    x += 1 while x < array.length
    num << array[x] if yield(array[x])
  end
end
