# frozen_string_literal: true

# https://adventofcode.com/2021/day/7

# All the crabs
class Crabs
  attr_accessor :horizontals

  def initialize(input_data_filename)
    @horizontals = File.open(input_data_filename, &:readline).chomp.split(',').map(&:to_i)
  end

  def average
    @horizontals.sum / @horizontals.length
  end

  def fuel_to(horizontal)
    @horizontals.reduce(0) { |sum, h| sum + (horizontal - h).magnitude }
  end
end

puts "\nTest dataset:"
crabs = Crabs.new('day07-input-test.txt')
puts "It would take #{crabs.fuel_to crabs.average} units of fuel to get to their average horizontal position"
