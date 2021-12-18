# frozen_string_literal: true

# https://adventofcode.com/2021/day/17
class Probe
  attr_accessor :start, :position, :initial_direction, :current_direction, :target, :trajectory, :hit, :max_y_reached

  def initialize(starting_point, direction, target)
    @start = starting_point.clone
    @position = starting_point.clone
    @max_y_reached = starting_point[1]
    @initial_direction = direction.clone
    @current_direction = direction.clone
    @target = target
    @hit = false
    plot_trajectory
  end

  def plot_trajectory
    @trajectory = [@start]
    while keep_going?
      @position[0] = @position[0] + @current_direction[0]
      @position[1] = @position[1] + @current_direction[1]
      @trajectory << @position.clone
      @max_y_reached = @position[1] if @position[1] > @max_y_reached
      @current_direction[0] = [0, @current_direction[0] - 1].max
      @current_direction[1] = @current_direction[1] - 1
    end
  end

  def keep_going?
    return false if @position[0] > @target[1] || @position[1] > @target[3]

    if in_target?
      @hit = true
      return false
    end
    true
  end

  def in_target?
    @position[0] >= @target[0] && @position[0] <= @target[1] && @position[1] >= @target[2] && @position[1] <= @target[3]
  end

  def visualize_trajectory
    y_start = [0, @max_y_reached].max
    grid = Array.new(1 + y_start - @target[2]) { |_| Array.new(@target[1] + 1, '.') }
    (@target[0]..target[1]).each do |x|
      (@target[2]..@target[3]).each do |y|
        grid[(y - y_start).magnitude][x] = 'T'
      end
    end
    (0..@target[1]).each do |x|
      (@target[2]..y_start).each do |y|
        grid[(y - y_start).magnitude][x] = '*' if @trajectory.include? [x, y]
      end
    end
    grid.each { |row| puts row.join }
    grid.map(&:join)
  end
end

class ProbeLauncher
  attr_accessor :target, :probes

  def initialize(target_description)
    @target = parse_target_description(target_description)
    calculate_probes
  end

  def calculate_probes
    # Needn't go below 45 degrees nor beyond the extent of the target
    @probes = []
    (1..10).each do |y_mag|
      (1..10).each do |x_mag|
        @probes << Probe.new([0, 0], [x_mag, y_mag], @target)
      end
    end
  end

  # E.g. 'target area: x=20..30, y=-10..-5' becomes [20, 30, -10, -5]
  def parse_target_description(description)
    /x=([-\d.]*).*y=([-\d.]*)/.match(description).captures.map { |e| e.split('..').map(&:to_i) }.flatten(1)
  end

  def max_y_reached
    @probes.select(&:hit).max { |a, b| a.max_y_reached <=> b.max_y_reached }.max_y_reached
  end
end

def launch(description)
  launcher = ProbeLauncher.new
  target = launcher.parse_target_description(description)
  launcher.target = target
  max_y = launcher.max_y_reached
  puts "The maximum reachable y is #{max_y} given the target '#{description}'"
end

launch('target area: x=143..177, y=-106..-71') if __FILE__ == $PROGRAM_NAME
