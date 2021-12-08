# frozen_string_literal: true

# https://adventofcode.com/2021/day/8

class ObservedData
  attr_accessor :segment_counts, :digit_mapping

  def initialize(input_data_filename)
    @digit_mapping = { 2 => 1, 3 => 7, 4 => 4, 7 => 8 }
    lines = File.readlines(input_data_filename).map(&:chomp).map { |l| l.slice((l.index('|') + 1)..-1).split }
    @segment_counts = lines.map { |l| l.map(&:length) }.flatten.tally
  end

  def answer
    @digit_mapping.keys.reduce(0) { |m, k| m + @segment_counts[k] }
  end
end

data = ObservedData.new('day08-input-test.txt')
puts data.answer

data = ObservedData.new('day08-input-01.txt')
puts data.answer
