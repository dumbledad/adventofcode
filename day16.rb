# frozen_string_literal: true

# https://adventofcode.com/2021/day/16
class Transmission
  attr_accessor :transmissions

  def initialize(input_data_filename: '')
    return if input_data_filename.empty?

    @transmissions = File.readlines(input_data_filename).map(&:chomp).map { |h| h.unpack1('H*').to_i }
  end

  def print_transmissions
    @transmissions.each do |t|
      puts t.to_s(2)
    end
  end

  def sum_version_numbers(packet_hex)
    packet = parse_packet(packet_to_int(packet_hex))
  end

  def packet_to_int(packet_hex)
    packet_hex.unpack1('H*').to_i
  end

  def parse_packet(packet_int)
    packet = {}
    packet[:version] = packet_int >> (packet_int.bit_length - 3)
    packet[:type] = (packet_int >> (packet_int.bit_length - 6)) & (((1 << 3) - 1) << 3)
    packet[:literal_value] = packet[:type] == 4 ? parse_literal_value(drop_top_bits(6, packet_int)) : 0
    packet
  end

  def parse_literal_value(packet_int_remainder)
    literal_value = 0
    loop do
      top_five = packet_int_remainder >> (packet_int_remainder.bit_length - 5)
      packet_int_remainder = drop_top_bits(5, packet_int_remainder)
      literal_value = (literal_value << 4) + drop_top_bits(1, top_five)
      break if top_five < 0b10000
    end
    literal_value
  end

  def drop_top_bits(drop_count, num)
    ones = (1 << (num.bit_length - drop_count)) - 1
    num & ones
  end
end

def path(filename)
  data = Transmission.new(input_data_filename: filename)
  data.print_transmissions
  # puts "The lowest risk path has #{data.dijkstra} risk (#{filename}#{msg})"
end

['day16-input-test.txt', 'day16-input-01.txt'].each { |f| path(f) } if __FILE__ == $PROGRAM_NAME

# 16
# 12
# 23
# 31
