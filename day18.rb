# frozen_string_literal: true

require 'json'

module Refinements
  refine String do
    def to_sn
      sn_array = JSON.parse(self)
      SnailfishNumber.from_array(sn_array)
    end
  end
end

# https://adventofcode.com/2021/day/18
class SnailfishNumber
  attr_accessor :left, :right, :value, :parent

  # Turn a suitable array into a snailfish number. N.B. as this is unwrapped a call further down the recursion chain may pass in a value and not an array.
  def self.from_array(sn_array)
    if sn_array.is_a? Array
      sn_number = SnailfishNumber.new
      sn_number.left = from_array(sn_array.first)
      sn_number.left.parent = sn_number
      sn_number.right = from_array(sn_array.last)
      sn_number.right.parent = sn_number
      return sn_number
    end
    return SnailfishNumber.new(value: sn_array) if sn_array.is_a? Numeric

    nil
  end

  def initialize(left: nil, right: nil, value: nil, parent: nil)
    @left = left
    @right = right
    @value = value
    @parent = parent
  end

  def to_a
    return @value unless @value.nil?

    [@left.to_a, @right.to_a]
  end

  def +(other)
    add(other)
  end

  def add(other)
    result = SnailfishNumber.new(left: self, right: other, parent: parent)
    result.left.parent = result
    result.right.parent = result
    result.reduce
  end

  def reduce
    to_expl = to_explode(0)
    if to_expl.nil?
      to_spl = to_split
      unless to_spl.nil?
        to_spl.split
        reduce
      end
    else
      to_expl.explode
      reduce
    end
    self
  end

  def to_explode(depth)
    depth += 1
    return self if depth > 4

    unless left.nil? || !left.pair?
      to_explode_from_left = left.to_explode(depth)
      return to_explode_from_left unless to_explode_from_left.nil?
    end
    unless right.nil? || !right.pair?
      to_explode_from_right = right.to_explode(depth)
      return to_explode_from_right unless to_explode_from_right.nil?
    end
    nil
  end

  def pair?
    !left.nil?
  end

  def explode
    raise 'It was said that "Exploding pairs will always consist of two regular numbers"' if left.value.nil? || right.value.nil?

    add_to_next_left(left.value)
    add_to_next_right(right.value)
    @left = nil
    @right = nil
    @value = 0
  end

  def add_to_next_left(to_add)
    return nil if parent.nil?

    if parent.right == self
      parent.left.add_to_rightest_value(to_add)
    else
      parent.add_to_next_left(to_add)
    end
  end

  def add_to_next_right(to_add)
    if !parent.nil? && parent.left == self
      parent.right.add_to_leftest_value(to_add)
    else
      parent.add_to_next_right(to_add)
    end
  end

  def add_to_rightest_value(to_add)
    if @right.nil?
      @value += to_add
    else
      @right.add_to_rightest_value(to_add)
    end
  end

  def add_to_leftest_value(to_add)
    if @left.nil?
      @value += to_add
    else
      @left.add_to_leftest_value(to_add)
    end
  end

  def to_split
    return self if !@value.nil? && @value > 9

    unless left.nil?
      to_split_from_left = left.to_split
      return to_split_from_left unless to_split_from_left.nil?
    end
    unless right.nil?
      to_split_from_right = right.to_split
      return to_split_from_right unless to_split_from_right.nil?
    end
    nil
  end

  def split
    @left = SnailfishNumber.new(value: @value / 2, parent: self)
    @right = SnailfishNumber.new(value: (@value + 1) / 2, parent: self)
    @value = nil
  end

  # The magnitude of a pair is 3 times the magnitude of its left element plus 2 times the magnitude of its right element. The magnitude of a regular number is just
  # that number
  def magnitude
    return 3 * @left.magnitude + 2 * @right.magnitude if @value.nil?

    @value
  end
end

using Refinements

def part_one(filename)
  sn_numbers = File.readlines(filename).map(&:chomp).map(&:to_sn)
  added = sn_numbers.drop(1).reduce(sn_numbers[0]) { |sum, sn| sum + sn }
  result = added.magnitude
  puts "The magnitude of the sum of the snailfish numbers described in #{filename} is #{result}"
end

part_one('day18-input-01.txt') if __FILE__ == $PROGRAM_NAME
