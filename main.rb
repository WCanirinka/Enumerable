module Enumerable
    def my_each(array)
        num = []
        x = 0
        while x < array.length
            num << yield(array[x])
            x += 1
        end
        return num
    end

    def my_each_with_index(array)
        num = []
        x = 0
        while x < array.length
            num << yield(array[x], x)
            x += 1
        end
        return num
    end

    def my_select(array)
        num = []
        x = 0
        while x < array.length
            num << yield(array[x])
            x += 1
        end
        return num
    end
end