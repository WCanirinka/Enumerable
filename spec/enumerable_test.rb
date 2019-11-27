# frozen_string_literal: true

# spec/enumerable_spec.rb

require './enumerable.rb'

RSpec.describe Enumerable do
  describe '#my_all?' do
    it 'Return true if all the words on the array have 3 letters or more' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be_truthy
    end

    it 'Return true if all the words on the array have 4 letters or more' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to be_falsy
    end

    it "Return true if all the words on the array have the letter 't' on it" do
      expect(%w[ant bear cat].my_all?(/t/)).to be_falsy
    end

    it "Return true if all the words on the array start with 'T'" do
      expect(%w[Tia Tib Tic].my_all?(/T\w+/)).to be_truthy
    end

    it 'Return true if all the elements on the array are numeric' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be_truthy
    end

    it 'Return true if all the elements on the array return true' do
      expect([nil, true, 99].my_all?).to be_falsy
    end

    it 'Return true if you have an empty array and no block' do
      expect([].my_all?).to be_truthy
    end

    it 'Return true if you have an empty array and any block' do
      expect([].my_all? { |x| x == 8273 }).to be_truthy
    end

    it 'Return true if all the elements on the array are numeric' do
      expect([5, 5, 5].my_all?(5)).to be_truthy
    end

    it 'Return true if all element of range match' do
      expect((1..2).my_all? { |x| x >= 1 }).to be_truthy
    end
  end

  describe '#my_any?' do
    it 'Return true if any of the words on the arrays has a length greater or equal 3' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to be_truthy
    end

    it 'Return true if any of the words on the arrays has a length greater or equal 5' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to be_falsy
    end

    it "Return true if any of the words on the arrays has a 'd'" do
      expect(%w[ant bear cat].my_any?(/d/)).to be_falsy
    end

    it "Return true if any of the words on the arrays has a 'r'" do
      expect(%w[ant bear cat].my_any?(/r/)).to be_truthy
    end

    it 'Return true if any of the elements of the arrays is an Integer' do
      expect([nil, true, 99].my_any?(Integer)).to be_truthy
    end

    it 'Return true if there is no block and array is not empty' do
      expect([nil, false, 99].my_any?).to be_truthy
    end

    it 'Return false if there is no block and array is empty' do
      expect([].my_any?).to be_falsy
    end

    it 'Return true if there is no any element in the array thar match the element' do
      expect([5, 6, 7].my_any?(5)).to be_truthy
    end

    it 'Return true if all element of range match' do
      expect((1..2).my_any? { |x| x > 1 }).to be_truthy
    end
  end

  describe '#my_none?' do
    it 'Return true if there is no block and the array is empty' do
      expect([].my_none?).to be_truthy
    end

    it 'Return true if you have an empty array and any block' do
      expect([].my_none? { |x| x == 8273 }).to be_truthy
    end

    it 'Return true if no element of array match block' do
      expect([5, 6, 7, 8].my_none? { |x| x < 5 }).to be_truthy
    end

    it 'Return true if no element of array match block' do
      expect(%w[a b b].my_none? { |x| x.eql?('a') }).to be_falsy
    end

    it 'Return false if any element of range match' do
      expect((1..2).my_none? { |x| x > 1 }).to be_falsy
    end
  end

  describe '#my-inject' do
    it 'Take a block w/2 parameters and initial value and return the result of said block on each elem and initial' do
      expect((1..5).my_inject(0) { |x, y| x + y }).to eql((1..5).inject(0) { |x, y| x + y })
    end

    it 'Take a proc w/2 params and initial value. Return the result of applying said proc to each elem and initial' do
      operation = proc { |initial, item| initial + item }
      expect((1..5).my_inject(0, &operation)).to eql((1..5).inject(0, &operation))
    end

    it 'Take a symbol w/2 parameters and initial value and return the result of said sym on each element and initial' do
      expect((1..5).my_inject(0, :+)).to eql((1..5).inject(0, :+))
    end

    it 'Take a block with 2 parameters and return the result of said block on each element in sequence' do
      expect((1..5).my_inject { |x, y| x + y }).to eql((1..5).inject { |x, y| x + y })
    end

    it 'Take a proc with 2 parameters and return the result of said proc on each element in sequence' do
      operation = proc { |initial, item| initial + item }
      expect((1..5).my_inject(&operation)).to eql((1..5).inject(&operation))
    end

    it 'Take a symbol with 2 parameters and return the result of said symbol on each element in sequence' do
      expect((1..5).my_inject(:+)).to eql((1..5).inject(:+))
    end

    it 'Take a symbol with 2 parameters and return the result of applying said symbol to each element in sequence' do
      expect([1, 2, 3, 4, 5].my_inject(:+)).to eql([1, 2, 3, 4, 5].inject(:+))
    end
  end

  describe '#my_count' do
    it 'Takes a block as parameter and returns number of elements that pass the test defined in block' do
      expect([1, 2, 3, 4, 5].my_count { |x| x > 3 }).to eql([1, 2, 3, 4, 5].count { |x| x > 3 })
    end

    it 'Takes an item as parameter and returns number of elements that are equal in the enumerable ' do
      expect((1...5).my_count(2)).to eql((1...5).count(2))
    end

    it 'Returns number of elements in enumerable' do
      expect((1...5).my_count).to eql((1...5).count)
    end

    it 'Empty array should return 0' do
      expect([].my_count).to eql(0)
    end
  end

  describe '#my_select' do
    it 'Returns an Array containing all elements passing test defined in block' do
      expect([1, 2, 3, 4, 5].my_select { |x| x > 3 }).to eql([1, 2, 3, 4, 5].select { |x| x > 3 })
    end

    it 'Returns to_enum if no block is specified' do
      expect([1, 2, 3, 4, 5].my_select).to be_kind_of(Enumerator)
    end

    it 'Select from range' do
      expect((1..5).my_select { |x| x > 3 }).to eql((1..5).select { |x| x > 3 })
    end

    it 'Enumerator from range' do
      expect((1..5).my_select).to be_kind_of(Enumerator)
    end
  end
end