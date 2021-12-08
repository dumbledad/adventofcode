# frozen_string_literal: true

# https://adventofcode.com/2021/day/8
class ObservedData
  attr_accessor :readings

  def initialize(input_data_filename)
    @readings = []
    File.readlines(input_data_filename).map(&:chomp).map do |l|
      signal_patterns = order_chars_in_strings l.split('|')[0]
      output_values = order_chars_in_strings l.split('|')[1]
      @readings << { signal_patterns: signal_patterns, output_values: output_values }
    end
  end

  def order_chars_in_strings(str_of_strs)
    str_of_strs.split.map { |s| s.chars.sort.join }
  end

  def unique_segment_count_digits
    @unique_segment_count_digits ||= { 2 => 1, 3 => 7, 4 => 4, 7 => 8 }
  end

  def segments_to_digits
    @segments_to_digits ||= { 'abcefg' => '0',
                              'cf' => '1',
                              'acdeg' => '2',
                              'acdfg' => '3',
                              'bcdf' => '4',
                              'abdfg' => '5',
                              'abdefg' => '6',
                              'acf' => '7',
                              'abcdefg' => '8',
                              'abcdfg' => '9' }
  end

  def segment_counts
    @segment_counts ||= @readings.map { |r| r[:output_values].map(&:length) }.flatten.tally
  end

  def uniques_count
    @uniques_count ||= unique_segment_count_digits.keys.reduce(0) { |m, k| m + segment_counts[k] }
  end

  def all_segments
    @all_segments ||= [a, b, c, d, e, f, g]
  end

  def derive_digits(reading)
    segment_mapping = derive_segment_mapping(reading[:signal_patterns])
    digits = reading[:output_values].map { |s| segments_to_digits[s.chars.map { |c| segment_mapping[c] }.sort.join] }
    digits.join.to_i
  end

  def sum_derived_digits
    readings.map { |r| derive_digits(r) }.sum
  end

  def derive_segment_mapping(signal_patterns)
    signals = signal_patterns.map(&:chars)
    segment_mapping = {}
    a_signal = find_a signals
    segment_mapping[a_signal] = 'a'
    d_signal = find_d signals
    segment_mapping[d_signal] = 'd'
    b_signal = find_b(signals, d_signal)
    segment_mapping[b_signal] = 'b'
    f_signal = find_f signals
    segment_mapping[f_signal] = 'f'
    c_signal = find_c(signals, f_signal)
    segment_mapping[c_signal] = 'c'
    g_signal = find_g(signals, [a_signal, b_signal, c_signal, d_signal, f_signal])
    segment_mapping[g_signal] = 'g'
    segment_mapping[find_e(signals, [a_signal, b_signal, c_signal, d_signal, f_signal, g_signal])] = 'e'
    segment_mapping
  end

  def find_a(signals)
    # What signal is intened to be 'a', i.e. the segment in 7 but not in 1
    (signals.find { |s| s.length == 3 } - signals.find { |s| s.length == 2 })[0]
  end

  def find_d(signals)
    # What signal is intened to be 'd', i.e. not in 0, but in other 6 segment numbers
    signals.select { |s| s.length == 6 }.flatten.tally.find { |_, v| v == 1 }[0]
  end

  def find_b(signals, maps_to_d)
    # What signal is intended to be 'b', i.e. the one in 4 that's not 'd' nor in 1
    (signals.find { |s| s.length == 4 } - (signals.find { |s| s.length == 2 } << maps_to_d))[0]
  end

  def find_f(signals)
    # What signal is intended to be 'f', i.e. the one missing from only one digit
    signals.flatten.tally.find { |_, v| v == 9 }[0]
  end

  def find_c(signals, maps_to_f)
    # What signal is intended to be 'c', i.e. the one in 1 that is not f
    (signals.find { |s| s.length == 2 } - maps_to_f)[0]
  end

  def find_g(signals, a_b_c_d_f)
    # What signal is intended to be 'g', i.e. the one in the two 5 segment digits (3 and 5) that's not a, b, c, d, nor f
    (signals.find { |s| s.length == 5 }.flatten.unique - a_b_c_d_f)[0]
  end

  def find_e(signals, a_b_c_d_f_g)
    # What signal is intended to be 'e', i.e. the one in 8 that is not a, b, c, d, nor f
    (signals.find { |s| s.length == 7 } - a_b_c_d_f_g)[0]
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = ObservedData.new('day08-input-test.txt')
puts "The digits 1, 4, 7, or 8 appear #{data.uniques_count} times"
puts "\nFull dataset:"
data = ObservedData.new('day08-input-01.txt')
puts "The digits 1, 4, 7, or 8 appear #{data.uniques_count} times"

puts "\nPART TWO"
puts "\nTest dataset:"
data = ObservedData.new('day08-input-test.txt')
puts "The sum of decoded four-digit output values is #{data.sum_derived_digits}"
puts "\nFull dataset:"
data = ObservedData.new('day08-input-01.txt')
puts "The sum of decoded four-digit output values is #{data.sum_derived_digits}"
