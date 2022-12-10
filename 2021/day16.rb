# frozen_string_literal: true

# https://adventofcode.com/2021/day/16
class Transmission
  attr_accessor :hex_to_bin

  def initialize
    @hex_to_bin = [*'0'..'9', *'A'..'F'].zip((0..15).map { |i| format('../inputs/2021/%04b', i) }).to_h # https://stackoverflow.com/a/29857016/575530
  end

  def print_transmissions
    @transmissions.each do |t|
      puts t.to_s(2)
    end
  end

  def sum_version_numbers(packet)
    version_sum = packet[:version]
    packet[:sub_packets].each do |p|
      version_sum += sum_version_numbers(p)
    end
    version_sum
  end

  def calculate_result(packet)
    case packet[:type]
    when 0
      packet[:sub_packets].reduce(0) { |sum, p| sum + calculate_result(p) }
    when 1
      packet[:sub_packets].reduce(1) { |prod, p| prod * calculate_result(p) }
    when 2
      packet[:sub_packets].map { |p| calculate_result(p) }.min
    when 3
      packet[:sub_packets].map { |p| calculate_result(p) }.max
    when 4
      packet[:literal_value]
    when 5
      calculate_result(packet[:sub_packets][0]) > calculate_result(packet[:sub_packets][1]) ? 1 : 0
    when 6
      calculate_result(packet[:sub_packets][0]) < calculate_result(packet[:sub_packets][1]) ? 1 : 0
    when 7
      calculate_result(packet[:sub_packets][0]) == calculate_result(packet[:sub_packets][1]) ? 1 : 0
    end
  end

  def packet_to_bin(packet_hex)
    packet_hex.each_char.map { |h| @hex_to_bin[h] }.join
  end

  def parse_packet(packet_bin)
    packet = {}
    packet[:version] = packet_bin[0, 3].to_i(2)
    packet[:type] = packet_bin[3, 3].to_i(2)
    if packet[:type] == 4
      packet[:literal_value], remainder = parse_literal_value(packet_bin[6..])
      packet[:sub_packets] = []
    else
      packet[:literal_value] = 0
      packet[:sub_packets], remainder = parse_operator(packet_bin[6..])
    end
    [packet, remainder]
  end

  def parse_literal_value(packet_bin_remainder)
    literal_value = ''
    loop do
      top_five_bits = packet_bin_remainder[0, 5]
      packet_bin_remainder = packet_bin_remainder[5..]
      literal_value += top_five_bits[1..]
      break if top_five_bits[0] == '0'
    end
    [literal_value.to_i(2), packet_bin_remainder]
  end

  def parse_operator(packet_bin_remainder)
    length_type_id = packet_bin_remainder[0]
    if length_type_id == '0'
      sub_packets_length = packet_bin_remainder[1, 15].to_i(2)
      sub_packets = parse_sub_packets(packet_bin_remainder[16, sub_packets_length])
      remainder = packet_bin_remainder[(16 + sub_packets_length)..]
    else
      num_sub_packets = packet_bin_remainder[1, 11].to_i(2)
      sub_packets, remainder = parse_n_sub_packets(num_sub_packets, packet_bin_remainder[12..])
    end
    [sub_packets, remainder]
  end

  def parse_sub_packets(packet_bin_fragment)
    packets = []
    remainder = packet_bin_fragment
    while remainder.length.positive?
      packet, remainder = parse_packet(remainder)
      packets << packet
    end
    packets
  end

  def parse_n_sub_packets(sub_packet_count, packet_bin_remainder)
    packets = []
    remainder = packet_bin_remainder
    while packets.length < sub_packet_count
      packet, remainder = parse_packet(remainder)
      packets << packet
    end
    [packets, remainder]
  end
end

def path(filename)
  transmission = Transmission.new
  packet_hex = File.open(filename, &:readline).chomp
  packet_bin = transmission.packet_to_bin(packet_hex)
  packet, = transmission.parse_packet(packet_bin)
  sum = transmission.sum_version_numbers(packet)
  puts "The sum of the packet values is #{sum} from the transmission in #{filename}"
  result = transmission.calculate_result(packet)
  puts "The result of the calculation is #{result} from the transmission in #{filename}"
end

path('../inputs/2021/day16-input-01.txt') if __FILE__ == $PROGRAM_NAME
