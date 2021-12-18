# frozen_string_literal: true

require 'json'

module Refinements
  refine Array do
    def depth
      map { |element| element.depth + 1 }.max
    end
  end

  refine Object do
    def depth
      0
    end
  end

  refine String do
    def to_sn(sn_string)
      JSON.parse(sn_string)
    end
  end
end

# https://adventofcode.com/2021/day/18
class SnailfishNumber
  using Refinements

  def self.add(array_a, array_b)
    SnailfishNumber.reduce [array_a, array_b]
  end

  def self.reduced(sn_array, nesting: 0)
    return true if sn_array.depth <= 4

    sn_array.each do |sna|
      return false if sna.is_a? Numeric && sna < 10
      if sna.is_a? Numeric
      end

  end
end
