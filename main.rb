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

  def my_any?(array)
    x = 0
    while x < array.length
      if yield(array[x])
        true
      end
      x += 1
    end
    false
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

  def my_inject(array)
    num = array[0]
    x = 0
    while x < array.length
      num = yield(num, array[x])
      x += 1
    end
    num
  end

  def multiply_els(array)
    my_inject(array) do |result, i|
      result * i
    end
  end

  def my_map_pro(array, pro)
    num = []
    x = 0
    while x < array.length
      num << pro.call(array[x])
      x += 1
    end
    num
  end

  def my_map_proc(array, pro)
    num = []
    x = 0
    while x < array.length
      if block_given?
        num << yield(array[x])
      else
        num << pro.call(array[x])
      end
      x += 1
    end
    return num
  end
end
