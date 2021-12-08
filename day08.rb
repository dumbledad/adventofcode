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

  # Solution to Part 1
  def uniques_count
    @uniques_count ||= unique_segment_count_digits.keys.reduce(0) { |m, k| m + segment_counts[k] }
  end

  def derive_digits(reading)
    segment_mapping = derive_segment_mapping(reading[:signal_patterns])
    digits = reading[:output_values].map { |s| segments_to_digits[s.chars.map { |c| segment_mapping[c] }.sort.join] }
    digits.join.to_i
  end

  # Solution to Part 2
  def sum_derived_digits
    readings.map { |r| derive_digits(r) }.sum
  end

  def derive_segment_mapping(signal_patterns)
    signals = signal_patterns.map(&:chars)
    segment_mapping = {}
    a_signal = find_a(signals, segment_mapping)
    f_signal = find_f(signals, segment_mapping)
    g_signal = find_g(signals, segment_mapping, a_signal)
    c_signal = find_c(signals, segment_mapping, f_signal)
    d_signal = find_d(signals, segment_mapping, [a_signal, c_signal, f_signal, g_signal])
    b_signal = find_b(signals, segment_mapping, d_signal)
    find_e(signals, segment_mapping, [a_signal, b_signal, c_signal, d_signal, f_signal, g_signal])
    segment_mapping
  end

  def find_a(signals, segment_mapping)
    # What signal is intened to be 'a', i.e. the segment in 7 but not in 1
    a_signal = (signals.find { |s| s.length == 3 } - signals.find { |s| s.length == 2 })[0]
    segment_mapping[a_signal] = 'a'
    a_signal
  end

  def find_b(signals, segment_mapping, maps_to_d)
    # What signal is intended to be 'b', i.e. the one in 4 that's not 'd' nor in 1
    b_signal = (signals.find { |s| s.length == 4 } - (signals.find { |s| s.length == 2 }.clone << maps_to_d))[0]
    segment_mapping[b_signal] = 'b'
    b_signal
  end

  def find_c(signals, segment_mapping, maps_to_f)
    # What signal is intended to be 'c', i.e. the one in 1 that is not f
    c_signal = (signals.find { |s| s.length == 2 } - maps_to_f.chars)[0]
    segment_mapping[c_signal] = 'c'
    c_signal
  end

  def find_d(signals, segment_mapping, a_c_f_g)
    # What signal is intened to be 'd', i.e. 3 is only 5 segment digit containing a, c, f, and g and its remaining
    # segment is d
    three = signals.find { |s| s.length == 5 && (a_c_f_g - s).empty? }
    d_signal = (three - a_c_f_g)[0]
    segment_mapping[d_signal] = 'd'
    d_signal
  end

  def find_e(signals, segment_mapping, a_b_c_d_f_g)
    # What signal is intended to be 'e', i.e. the one in 8 that is not a, b, c, d, nor f
    e_signal = (signals.find { |s| s.length == 7 } - a_b_c_d_f_g)[0]
    segment_mapping[e_signal] = 'e'
    e_signal
  end

  def find_f(signals, segment_mapping)
    # What signal is intended to be 'f', i.e. the one missing from only one digit
    f_signal = signals.flatten.tally.find { |_, v| v == 9 }[0]
    segment_mapping[f_signal] = 'f'
    f_signal
  end

  def find_g(signals, segment_mapping, maps_to_a)
    # What signal is intended to be 'g', i.e. of the six segment digit containg 4 and a (9) it's the remaining segment
    four_plus_a = (signals.find { |s| s.length == 4 }.clone << maps_to_a)
    g_signal = (signals.find { |s| s.length == 6 && (four_plus_a - s).empty? } - four_plus_a)[0]
    segment_mapping[g_signal] = 'g'
    g_signal
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
