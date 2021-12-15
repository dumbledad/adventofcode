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

        @risks.length.times { expanded << [] } if j.zero?

        incremented = increment(previous_block(i, j, expanded))
        append_incremented(expanded, incremented)
      end
    end
    expanded
  end

  def append_incremented(expanded, incremented)
    (0...incremented.length).each do |ii|
      expanded[(i * @risks.length) + ii] = expanded[(i * @risks.length) + ii] + incremented[ii]
    end
  end

  def previous_block(i_idx, j_idx, expanded)
    return previous_block_up(i_idx, expanded) if j_idx.zero?

    previous_block_left(i_idx, j_idx, expanded)
  end

  def previous_block_up(i_idx, expanded)
    sub_matrix(expanded, (i_idx - 1) * @risks.length, @risks.length, 0, @risks[0].length)
  end

  def previous_block_left(i_idx, j_idx, expanded)
    sub_matrix(expanded, i_idx * @risks.length, @risks.length, (j_idx - 1) * @risks[0].length, @risks[0].length)
  end

  def sub_matrix(matrix, i_idx, i_length, j_idx, j_length)
    matrix[i_idx, i_length].map { |r| r[j_idx, j_length] }
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
      revise_risk_for_adjacents(start, points)
    end
    points[@i_length - 1][@j_length - 1][:risk_from_start].to_i
  end

  def revise_risk_for_adjacents
    adjacents(start, points).reject { |p| p[:calculated] }.each do |p|
      revised_risk_from_start = start[:risk_from_start] + p[:risk].to_f
      p[:risk_from_start] = revised_risk_from_start if revised_risk_from_start < p[:risk_from_start]
    end
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
  msg = expand ? ' expanded' : ''
  puts "The lowest risk path has #{data.dijkstra} risk (#{filename}#{msg})"
end

[false, true].each { |e| ['day15-input-test.txt', 'day15-input-01.txt'].each { |f| path(f, e) } }

# data = Chitons.new('day15-input-test.txt', expand: true)
# data.print_risks
# risks = File.readlines('day15-expanded-test.txt').map(&:chomp).map(&:chars).map { |r| r.map(&:to_i) }
# (0...risks.length).each do |i|
#   (0...risks[0].length).each do |j|
#     puts "(#{i}, #{j}) == (#{data.risks[i][j]}, #{risks[i][j]})"
#     return if data.risks[i][j] != risks[i][j]
#   end
# end
