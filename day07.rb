# frozen_string_literal: true

# https://adventofcode.com/2021/day/7

# All the crabs
class Crabs
  attr_accessor :horizontals, :fuel_costs

  def initialize(input_data_filename, increasing)
    @horizontals = File.open(input_data_filename, &:readline).chomp.split(',').map(&:to_i)
    @fuel_costs = {}
    (@horizontals.min...@horizontals.max).each do |target|
      @fuel_costs[target] = fuel_to(target, increasing)
    end
  end

  def fuel_to(horizontal, increasing)
    return @horizontals.reduce(0) { |sum, h| sum + (horizontal - h).magnitude } unless increasing

    @horizontals.reduce(0) { |sum, h| sum + (1...(horizontal - h).magnitude).sum }
  end

  def min_fuel_cost
    cost = [@fuel_costs.min_by { |_, f| f }].first
    { horizontal: cost[0], fuel: cost[1] }
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
crabs = Crabs.new('day07-input-test.txt', false)
puts "It would take #{crabs.min_fuel_cost[:fuel]} units of fuel to get to #{crabs.min_fuel_cost[:horizontal]}"
puts "\nTest dataset:"
crabs = Crabs.new('day07-input-01.txt', false)
puts "It would take #{crabs.min_fuel_cost[:fuel]} units of fuel to get to #{crabs.min_fuel_cost[:horizontal]}"
puts "\nPART TWO"
puts "\nTest dataset:"
crabs = Crabs.new('day07-input-test.txt', true)
puts "It would take #{crabs.min_fuel_cost[:fuel]} units of fuel to get to #{crabs.min_fuel_cost[:horizontal]}"
puts "\nTest dataset:"
crabs = Crabs.new('day07-input-01.txt', true)
puts "It would take #{crabs.min_fuel_cost[:fuel]} units of fuel to get to #{crabs.min_fuel_cost[:horizontal]}"
puts ''
