# frozen_string_literal: false

module Enumerable
  def my_each
    return to_enum unless block_given?

    x = 0
    while x < self.length
      yield(self[x])
      x += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    x = 0
    while x < self.length
      yield(self[x], x)
      x += 1
    end
    self
  end

  def my_select
    return to_enum(:my_each) if !block_given?

    arr = []
    x = 0
    while x < self.length
      if yield(self[x])
        arr << self[x]
      end
      x += 1
    end
    arr
  end

  def my_all?(pat = nil)
    result = true
    if block_given?
      my_each { |ele| result &= (yield ele) }
    elsif pat
      my_each { |ele| result &= pat === ele }
    else
      my_each { |ele| result &= ele }
    end
    result
  end

  def my_any?(pat = nil)
    result = false
    if block_given?
      my_each { |ele| result = true if yield ele }
    elsif pat
      my_each { |ele| result = true if pattern?(ele, pat) }
    else
      my_each { |ele| result = true if ele }
    end
    result
  end

  def my_none?(pat = nil)
    result = true
    if block_given?
      my_each { |ele| result = false if yield ele }
    elsif pat
      my_each { |ele| result = false if pattern?(ele, pat) }
    else
      my_each { |ele| result = false if ele }
    end
    result
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |x| count += 1 if yield(x) }
    elsif arg
      my_each { |x| count += 1 if x == arg }
    else
      count = length
    end
    count
  end

  def my_map(param = nil)
    return to_enum unless block_given?

    new_arr = []
    if block_given?
      my_each { |x| new_arr << yield(x) }
    else
      my_each { |x| new_arr << param.call(x) }
    end
    new_arr
  end

  def my_inject(*args)
    result, sym = inj_param(*args)
    arr = result ? to_a : to_a[1..-1]
    result ||= to_a[0]
    if block_given?
      arr.my_each { |x| result = yield(result, x) }
    elsif sym
      arr.my_each { |x| result = result.public_send(sym, x) }
    end
    result
  end

  def multiply_els
    my_inject { |x, y| x * y }
  end

  def pattern?(obj, pat)
    (obj.respond_to?(:eql?) && obj.eql?(pat)) ||
      (pat.is_a?(Class) && obj.is_a?(pat)) ||
      (pat.is_a?(Regexp) && pat.match(obj))
  end

  def inj_param(*args)
    result, sym = nil
    args.my_each do |arg|
      result = arg if arg.is_a? Numeric
      sym = arg unless arg.is_a? Numeric
    end
    [result, sym]
  end
end
