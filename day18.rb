# frozen_string_literal: true

# require 'json'

module Refinements
  # refine Array do
  #   def depth
  #     map { |element| element.depth + 1 }.max
  #   end
  # end

  # refine Object do
  #   def depth
  #     0
  #   end
  # end

  refine String do
    def to_sn(sn_string)
      # JSON.parse(sn_string)
      sn_string.scan(/[\[\],]|\d*/)
      # '[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]'.scan(/[\[\],]|\d*/)
    end
  end
end

# https://adventofcode.com/2021/day/18
class SnailfishNumber
  using Refinements

  def self.add(sn_array_a, sn_array_b)
    SnailfishNumber.reduce ['[', *sn_array_a, ',' *sn_array_b, ']']
  end

  def self.reduce(sn_array)
    depth = 0
    sn_array.each_with_index do |e, i|
      depth += 1 if e == '['
      depth -= 1 if e == ']'
      if depth > 4
        explode(sn_array, i)
        return reduce(sn_array)
      elsif /\d+/.match?(e) && e.to_i > 9
        split(sn_array, i)
        return reduce(sn_array)
      end
    end
    sn_array
  end

  def self.explode(sn_array, idx)
    to_explode = sn_array[i, 3] # Should be ['n', ',', 'm']
    explode_left_num = to_explode[0].to_i
    explode_right_num = to_explode[2].to_i
    (0...idx).reverse_each do |i|
      break if add_and_replace_if_number(sn_array, i, explode_left_num)
    end
    (idx + 1...sn_array.length).reverse_each do |i|
      break if add_and_replace_if_number(sn_array, i, explode_right_num)
    end
  end

  def self.add_and_replace_if_number(sn_array, idx, to_add)
    if /\d+/.match? sn_array[idx]
      sn_array[idx] = (sn_array[idx].to_i + to_add).to_s
      return true
    end
    false
  end

  def self.split(sn_array, idx)
    replacement = [sn_array[idx].to_i / 2, (sn_array[idx] + 1) / 2]
    sn_array[idx, 1] = replacement
  end
end
