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
    while x < array.length
      if yield(array[x])
        num << array[x]
      end
      x += 1
    end
    num
  end

  def my_all?(array)
    num = true
    x = 0
    while x < array.length
      unless yield(array[x])
        num = false
      end
      x += 1
    end
    num
  end

  def my_none?(array)
    num = false
    x = 0
    while x < array.length
      if yield(array[x])
        num = true
      end
      x += 1
    end
    num
  end

  def my_count(array)
    num = 0
    x = 0
    while x < array.length
      if yield(array[x])
        num += 1
      end
      x += 1
    end
    num
  end

  def my_map(array)
    num = []
    x = 0
    while x < array.length
      num << array[x]
      x += 1
    end
    num
  end
end
