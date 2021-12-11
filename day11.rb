# frozen_string_literal: true

# https://adventofcode.com/2021/day/11
class DumboOctopuses
  attr_accessor :levels, :steps, :flashes

  def initialize(input_data_filename)
    @levels = File.readlines(input_data_filename).map(&:chomp).map { |l| l.chars.map(&:to_i) }
    @steps = 100
    @flashes = 0
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = DumboOctopuses.new('day11-input-test.txt')
puts "There were #{data.flashes} flashes after #{data.steps} steps"
# puts "\nFull dataset:"
# data = DumboOctopuses.new('day11-input-01.txt')
# puts "There were #{data.flashes} flashes after #{data.steps} steps"
