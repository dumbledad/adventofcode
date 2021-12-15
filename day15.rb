# frozen_string_literal: true

# https://adventofcode.com/2021/day/15
class Chitons
  attr_accessor :risks, :i_length, :j_length

  def initialize(input_data_filename)
    @risks = File.readlines(input_data_filename).map(&:chomp).map(&:chars).map { |r| r.map(&:to_i) }
    @i_length = @risks.length
    @j_length = @risks[0].length
  end

  # Part 1
  # Good explanation: https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7/
  def dijkstra
    points = init_data_for_dijkstra
    while !all_done?(points)
      start = min_risk(points)
      start[:calculated] = true
      adjacents(start).reject { |p| p[:calculated] }.each do |p|
        revised_risk_from_start = start[:risk_from_start] + p[:risk].to_f
        p[:risk_from_start] = revised_risk_from_start if revised_risk_from_start < p[:risk_from_start]       
      end
    points[@i_length - 1][@j_length - 1][:risk_from_start]
  end

  def init_data_for_dijkstra
    points = []
    (0...@i_length).each { |i| (0...@j_length).each |j| points << { position: [i, j], risk: @risks[i][j], risk_from_start: Float::INFINITY, calculated: false } }
    points[0][0][:risk_from_start] = 0.0
    points
  end

  def all_done?(points)
    points.reduce(true) { |done, p| done && p[:calculated] }
  end

  def min_risk(points)
    points.select { |p| !p[:calculated] }.min { |a, b| a[:risk_from_start] <=> b[:risk_from_start] }
  end

  def adjacents(point)
    # Rubocop complains:
    #   Assignment Branch Condition size for adjacents is too high. [<1, 24, 6> 24.76/17] (convention:Metrics/AbcSize)
    # TODO: Find out from Patrick (or any experienced Ruby programmer) how they'd respond to that Rubocop complaint
    # about this method. To me it looks a very neat and readable method, but that may be my inexperience with Ruby.
    # https://codereview.stackexchange.com/q/271025/11084
    adjacent_points = []
    adjacent_points << [point[0] - 1, point[1]] unless point[0].zero? # N

    adjacent_points << [point[0], point[1] + 1] unless point[1] + 1 == @j_length # E

    adjacent_points << [point[0] + 1, point[1]] unless point[0] + 1 == @i_length # S

    adjacent_points << [point[0], point[1] - 1] unless point[1].zero? # W

    adjacent_points
  end
end

def path(filename)
  data = Chitons.new(filename)
  puts "The lowest risk path has #{data.dijkstra} risk (#{filename})"
end

['day15-input-test.txt'].each { |f| path(f) }
