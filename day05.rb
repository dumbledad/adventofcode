# frozen_string_literal: true

# https://adventofcode.com/2021/day/5

# A simple line, i.e. a list of points covered
class Line
  attr_accessor :points_string, :points, :end_points, :permit_diagonals

  def initialize(line, permit_diagonals = false)
    # e.g. '427,523 -> 427,790'
    @points_string = line
    @permit_diagonals = permit_diagonals
    @end_points = line.split(' -> ').map { |str| str.split(',').map(&:to_i) }
    @points = []
    interpolate
  end

  def horizontal?
    @end_points[0][1] == @end_points[1][1]
  end

  def vertical?
    @end_points[0][0] == @end_points[1][0]
  end

  def diagonal?
    (end_points[1][0] - @end_points[0][0]).magnitude == (end_points[1][1] - @end_points[0][1]).magnitude
  end

  def permitted?
    horizontal? || vertical? unless @permit_diagonals
    horizontal? || vertical? || diagonal?
  end

  private

  def interpolate
    return unless permitted?

    xy_direction = direction
    point = @end_points[0]
    @points << point
    while point != @end_points[1]
      point = [point[0] + xy_direction[0], point[1] + xy_direction[1]]
      @points << point
    end
  end

  def direction
    xy_direction = [@end_points[1][0] - @end_points[0][0], @end_points[1][1] - @end_points[0][1]]
    unitize xy_direction
  end

  def unitize(xy_direction)
    max_mag = [xy_direction[0].magnitude, xy_direction[1].magnitude].max
    return xy_direction if max_mag.zero? # Just in case our line is a point

    [xy_direction[0] / max_mag, xy_direction[1] / max_mag]
  end
end

# Discrete 2D map of the sea bed
class Map
  attr_accessor :lines, :intersections

  def initialize
    @lines = File.readlines('day05-input-test.txt').map(&:chomp).map { |l| Line.new l }
    tallies = @lines.map(&:points).flatten(1).tally
    @intersections = tallies.select { |_, v| v > 1 }.keys
  end
end

map = Map.new
puts map.intersections.length
