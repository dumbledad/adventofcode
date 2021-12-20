# frozen_string_literal: true

# https://adventofcode.com/2021/day/19
class Sensors
  attr_accessor :sensors

  def initialize
    @sensors = []
    lines = File.readlines(input_data_filename).map(&:chomp)
    lines.each do |l|
      if line.start_with? '---'
        sensor.do_transformations unless sensor.nil? || sensor.ordinal.zero?
        sensor&.build_vectors
        digit = line.match(/\d+/)[0]
        sensor = Sensor.new(digit)
        @sensors << sensor
      end
      sensor.beacons['x0'] << line.split(',').map(&:to_i) if line.length.positive?
    end
  end
end

class Sensor
  require 'matrix'

  attr_accessor :name, :beacons

  def initialize(name)
    @name = name
    @beacons = { 'x0' => [] }
    @ninety_around_x_ccw = Matrix[[1, 0, 0], [0, 0, -1], [0, 1, 0]]
  end

  # We assume Scanner 0 is correct, and that each other scanner "could be in any of 24 different orientations: facing positive or negative x, y, or z, and considering
  # any of four directions "up" from that facing."
  def do_transformations
    # No-op.
  end

  # https://en.wikipedia.org/wiki/Rotation_matrix
  def do_rotations(axis, beacons)
    new_beacons = beacons.clone
    %w[90 180 270].each do |r_str|
      new_beacons = new_beacons.map { |b| (@ninety_around_x_ccw * Vector[*b]).to_a }
      @beacons["#{axis}#{r_str}"] = new_beacons
    end
  end

  def build_vectors
    # No-op.
  end
end

def report(filename)
  # lines = File.read_
end
