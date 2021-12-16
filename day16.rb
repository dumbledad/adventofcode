# frozen_string_literal: true

# https://adventofcode.com/2021/day/16
class Transmission
  attr_accessor :transmissions

  def initialize(input_data_filename)
    @transmissions = File.readlines(input_data_filename).map(&:chomp).map { |h| h.unpack1('H*').to_i }
  end

  def print_transmissions
    @transmissions.each do |t|
      puts t.inspect(2)
    end
  end

  # def parse_version(bin)
  # end

  # def parse_type_id(bin)
  # end
end

def path(filename)
  data = Transmission.new(filename)
  data.print_transmissions
  # puts "The lowest risk path has #{data.dijkstra} risk (#{filename}#{msg})"
end

['day16-input-test.txt', 'day16-input-01.txt'].each { |f| path(f) }

# 16
# 12
# 23
# 31
