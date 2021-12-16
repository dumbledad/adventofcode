# frozen_string_literal: true

# https://adventofcode.com/2021/day/16
class Transmission
  attr_accessor :transmissions

  def initialize(input_data_filename)
    @transmissions = File.readlines(input_data_filename).map(&:chomp).map { |h| h.unpack1('H*').to_i }
  end

  def print_transmissions
    @transmissions.each do |t|
      puts t.to_s(2)
    end
  end

  def parse_packet_from(num)
    version = num >> (num.bit_length - 3)
    num & (1 << (num.bit_length - 3))
  end

  def drop_top_bits(drop_count, num)
    ones = (1 << drop_count) - 1
    num & (ones << (num.bit_length - drop_count))
  end

  def parse_version(bin_str)
    parse_n(3, bin_str)
  end

  def parse_type_id(bin_str)
    parse_n(3, bin_str)
  end

  def parse_n(n, bin_str)
    [bin_str[0, n].to_i(2), bin_str[n..]]
  end
end

def path(filename)
  data = Transmission.new(filename)
  data.print_transmissions
  # puts "The lowest risk path has #{data.dijkstra} risk (#{filename}#{msg})"
end

'day16-input-test.txt', 'day16-input-01.txt'].each { |f| path(f) }

# 16
# 12
# 23
# 31
