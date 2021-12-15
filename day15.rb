# frozen_string_literal: true

# https://adventofcode.com/2021/day/15
class Chitons
  attr_accessor :risks, :i_length, :j_length

  def initialize(input_data_filename, expand: false)
    @risks = File.readlines(input_data_filename).map(&:chomp).map(&:chars).map { |r| r.map(&:to_i) }
    @risks = expand_risks if expand
    # print_risks
    @i_length = @risks.length
    @j_length = @risks[0].length
  end

  def print_risks
    @risks.each { |r| puts r.map(&:to_i).join }
  end

  def expand_risks
    expanded = @risks.clone
    (0...5).each do |i|
      (0...5).each do |j|
        next if i.zero? && j.zero?

        if j.zero?
          @risks.length.times { expanded << [] }
          previous_block = expanded[(i - 1) * @risks.length, @risks.length].map { |r| r[0, @risks[0].length] }
        else
          previous_block = expanded[i, @risks.length].map { |r| r[(j - 1) * @risks[0].length, @risks[0].length] }
        end
        incremented = increment(previous_block)
        (0...incremented.length).each do |ii|
          expanded[(i * @risks.length) + ii] = expanded[(i * @risks.length) + ii] + incremented[ii]
        end
      end
    end
    expanded
  end

  def increment(risk_map)
    incremented = []
    (0...risk_map.length).each do |i|
      (0...risk_map[0].length).each do |j|
        incremented << [] if j.zero?
        incremented[i] << (risk_map[i][j] % 9) + 1
      end
    end
    incremented
  end

  # Part 1
  # Good explanation: https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7/
  def dijkstra
    points = init_data_for_dijkstra
    until all_done?(points)
      start = min_risk(points)
      start[:calculated] = true
      adjacents(start, points).reject { |p| p[:calculated] }.each do |p|
        revised_risk_from_start = start[:risk_from_start] + p[:risk].to_f
        p[:risk_from_start] = revised_risk_from_start if revised_risk_from_start < p[:risk_from_start]
      end
    end
    points[@i_length - 1][@j_length - 1][:risk_from_start].to_i
  end

  def init_data_for_dijkstra
    points = []
    (0...@i_length).each do |i|
      (0...@j_length).each do |j|
        points << [] if j.zero?
        points[i] << { position: [i, j], risk: @risks[i][j], risk_from_start: Float::INFINITY, calculated: false }
      end
    end
    points[0][0][:risk_from_start] = 0.0
    points
  end

  def all_done?(points)
    points.flatten(1).reduce(true) { |done, p| done && p[:calculated] }
  end

  def min_risk(points)
    points.flatten(1).reject { |p| p[:calculated] }.min { |a, b| a[:risk_from_start] <=> b[:risk_from_start] }
  end

  def adjacents(point, points)
    # Rubocop complains:
    #   Assignment Branch Condition size for adjacents is too high. [<1, 24, 6> 24.76/17] (convention:Metrics/AbcSize)
    # TODO: Find out from Patrick (or any experienced Ruby programmer) how they'd respond to that Rubocop complaint
    # about this method. To me it looks a very neat and readable method, but that may be my inexperience with Ruby.
    # https://codereview.stackexchange.com/q/271025/11084
    adjacent_points = []
    adjacent_points << points[point[:position][0] - 1][point[:position][1]] unless point[:position][0].zero?

    adjacent_points << points[point[:position][0]][point[:position][1] + 1] unless point[:position][1] + 1 == @j_length

    adjacent_points << points[point[:position][0] + 1][point[:position][1]] unless point[:position][0] + 1 == @i_length

    adjacent_points << points[point[:position][0]][point[:position][1] - 1] unless point[:position][1].zero?

    adjacent_points
  end
end

def path(filename, expand)
  data = Chitons.new(filename, expand: expand)
  puts "The lowest risk path has #{data.dijkstra} risk (#{filename})"
end

# [false, true].each { |e| ['day15-input-test.txt', 'day15-input-01.txt'].each { |f| path(f, e) } }

data = Chitons.new('day15-input-test.txt', expand: true)
data.print_risks
risks = File.readlines('day15-expanded-test.txt').map(&:chomp).map(&:chars).map { |r| r.map(&:to_i) }
(0...risks.length).each do |i|
  (0...risks[0].length).each do |j|
    puts "(#{i}, #{j}) == (#{data.risks[i][j]}, #{risks[i][j]})"
    return if data.risks[i][j] != risks[i][j]
  end
end
