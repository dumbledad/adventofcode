# frozen_string_literal: true

# https://adventofcode.com/2021/day/7

# All the crabs
class Crabs
  attr_accessor :horizontals, :fuel_costs

  def initialize(input_data_filename)
    @horizontals = File.open(input_data_filename, &:readline).chomp.split(',').map(&:to_i)
    set_fuel_costs
  end

  def set_fuel_costs
    @fuel_costs = {}
    (@horizontals.min...@horizontals.max).each do |target|
      @fuel_costs[target] = fuel_to target
    end
  end

  def fuel_to(horizontal)
    @horizontals.reduce(0) { |sum, h| sum + (horizontal - h).magnitude }
  end

  def min_fuel_cost
    cost = [@fuel_costs.min_by { |_, f| f }].first
    { :horizontal => cost[0], :fuel => cost[1] }
  end
end

puts "\nTest dataset:"
crabs = Crabs.new('day07-input-test.txt')
# puts "It would take #{crabs.fuel_to crabs.average} units of fuel to get to their average horizontal position"
puts crabs.min_fuel_cost[:fuel]
