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
        

    end
  end
end
