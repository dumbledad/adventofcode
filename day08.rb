# frozen_string_literal: true

# https://adventofcode.com/2021/day/8
class ObservedData
  def initialize(input_data_filename)
    File.readlines(input_data_filename).map(&:chomp).map do |l|
      signal_patterns = l.split('|')[0].split.map { |s| s.chars.sort.join }
      output_values = l.split('|')[1].split.map { |s| s.chars.sort.join }
      readings << { signal_patterns: signal_patterns, output_values: output_values }
    end
  end

  def unique_segment_count_digits
    @unique_segment_count_digits ||= { 2 => 1, 3 => 7, 4 => 4, 7 => 8 }
  end

  def readings
    @readings ||= []
  end

  def segment_counts
    @segment_counts ||= @readings.map { |r| r[:output_values].map(&:length) }.flatten.tally
  end

  def uniques_count
    @uniques_count ||= unique_segment_count_digits.keys.reduce(0) { |m, k| m + segment_counts[k] }
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = ObservedData.new('day08-input-test.txt')
puts "The digits 1, 4, 7, or 8 appear #{data.uniques_count} times"
puts "\nFull dataset:"
data = ObservedData.new('day08-input-01.txt')
puts "The digits 1, 4, 7, or 8 appear #{data.uniques_count} times"
