# frozen_string_literal: true

# https://adventofcode.com/2021/day/5

# A simple line, i.e. a list of point covered
class Line
  attr_accessor :points, :end_points

  def initialize(line)
    # e.g. '427,523 -> 427,790'
    @end_points = line.split(' -> ').reduce([]) do |acc, point_string|
      acc << point_string.split(',').map(&:to_i)
    end
  end
end

# Discrete 2D map of the sea bed
class Map
  attr_accessor :lines

  def initialize
    @lines = File.readlines('day05-input-01.txt').map(&:chomp).map { |l| Line.new l }
  end
end

map = Map.new
pp map.lines
