# frozen_string_literal: true

# https://adventofcode.com/2021/day/5

# A simple line, i.e. a list of points covered
class Line
  attr_accessor :points_string, :points, :end_points

  def initialize(line)
    # e.g. '427,523 -> 427,790'
    @points_string = line
    @end_points = line.split(' -> ').reduce([]) do |acc, point_string|
      acc << point_string.split(',').map(&:to_i)
    end
    @points = []
    interpolate
  end

  def horizontal?
    @end_points[0][1] == @end_points[1][1]
  end

  def vertical?
    @end_points[0][0] == @end_points[1][0]
  end

  private

  def interpolate
    if horizontal?
      (@end_points[0][0]..@end_points[1][0]).each do |x|
        @points << [x, @end_points[0][1]]
      end
    elsif vertical?
      (@end_points[0][1]..@end_points[1][1]).each do |y|
        @points << [@end_points[0][0], y]
      end
    end
  end
end

# Discrete 2D map of the sea bed
class Map
  attr_accessor :lines, :intersections

  def initialize
    @lines = File.readlines('day05-input-01.txt').map(&:chomp).map { |l| Line.new l }
    tallies = @lines.map(&:points).flatten(1).tally
    @intersections = tallies.select { |_, v| v > 1 }.keys
  end
end

map = Map.new
puts map.intersections.length
