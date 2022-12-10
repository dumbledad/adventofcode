# frozen_string_literal: true

# https://adventofcode.com/2021/day/9
class ObservedData
  attr_accessor :readings, :size

  def initialize(input_data_filename)
    @readings = File.readlines(input_data_filename).map(&:chomp).map { |l| l.chars.map(&:to_i) }
    @size = [readings.length, readings[0].length]
  end

  def minima
    min = []
    readings.each_index do |i|
      readings[i].each_index do |j|
        min << readings[i][j] if readings[i][j] < adjacents(i, j).min
      end
    end
    min
  end

  def risk_levels
    minima.map { |m| m + 1 }
  end

  def adjacents(i_index, j_index)
    adjacent_indexes(i_index, j_index).map { |p| readings[p[0]][p[1]] }
  end

  def adjacent_indexes(i_index, j_index)
    adj = []
    adj << [i_index - 1, j_index] if i_index.positive?
    adj << [i_index, j_index - 1] if j_index.positive?
    adj << [i_index + 1, j_index] if i_index + 1 < size[0]
    adj << [i_index, j_index + 1] if j_index + 1 < size[1]
    adj
  end

  def largest_basins(count)
    basins.to_a.sort { |b1, b2| b2.size <=> b1.size }.first(count)
  end

  # Part 2
  def product_of_largest_basins_sizes(count)
    largest_basins(count).map(&:size).reduce(1) { |s, m| m * s }
  end

  def basins
    basins = []
    # readings[i].each_index not working, it's enumerating the elements of readings[i] not the j indexes
    (0...size[0]).each do |i|
      (0...size[1]).each do |j|
        next if readings[i][j] == 9 || basins.flatten(1).include?([i, j])

        basins << non_nine_connecteds(i, j)
      end
    end
    basins
  end

  def non_nine_connecteds(i_index, j_index)
    to_check = [[i_index, j_index]]
    adjacents = []
    until to_check.empty?
      i_j = to_check.pop
      next if adjacents.include?(i_j) || readings[i_j[0]][i_j[1]] == 9

      adjacents << i_j
      to_check += adjacent_indexes(i_j[0], i_j[1]).reject do |adj|
        adjacents.include?(adj) || readings[adj[0]][adj[1]] == 9
      end
    end
    adjacents
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = ObservedData.new('../inputs/2021/day09-input-test.txt')
puts "The sum of risk levels is #{data.risk_levels.sum}"
puts "\nFull dataset:"
data = ObservedData.new('../inputs/2021/day09-input-01.txt')
puts "The sum of risk levels is #{data.risk_levels.sum}"

puts "\nPART TWO"
puts "\nTest dataset:"
data = ObservedData.new('../inputs/2021/day09-input-test.txt')
puts "The product of the three largest basin's sizes is #{data.product_of_largest_basins_sizes(3)}"
puts "\nFull dataset:"
data = ObservedData.new('../inputs/2021/day09-input-01.txt')
puts "The product of the three largest basin's sizes is #{data.product_of_largest_basins_sizes(3)}"
