# frozen_string_literal: true

# https://adventofcode.com/2021/day/17
class Probe
  attr_accessor :start, :trajectory, :result, :max_y_reached
end

class ProbeLauncher
  attr_accessor :target, :probes

  def initialize
    @probes = []
  end

  # E.g. 'target area: x=20..30, y=-10..-5' becomes [20, 30, -10, -5]
  def parse_target_description(description)
  end

  def max_y_reached
    @probes.max { |a, b| a.max_y_reached <=> b.max_y_reached }.max_y_reached
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
