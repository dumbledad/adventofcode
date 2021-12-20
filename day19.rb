# frozen_string_literal: true

# https://adventofcode.com/2021/day/19
class Sensors
  attr_accessor :sensors

  def initialize
    @sensors = []
    lines = File.readlines(input_data_filename).map(&:chomp)
    lines.each do |l|
      if line.start_with? '---'
        sensor.do_all_transformations unless sensor.nil? || sensor.ordinal.zero?
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

  attr_accessor :name, :beacons, :betweens

  # https://en.wikipedia.org/wiki/Rotation_matrix
  NINETY_AROUND_X_CCW = Matrix[[1, 0, 0], [0, 0, -1], [0, 1, 0]]
  NINETY_AROUND_Y_CCW = Matrix[[0, 0, 1], [0, 1, 0], [-1, 0, 0]]
  NINETY_AROUND_Z_CCW = Matrix[[0, -1, 0], [1, 0, 0], [0, 0, 1]]
  REFLECT_IN_YZ = Matrix[[-1, 0, 0], [0, 1, 0], [0, 0, 1]]
  REFLECT_IN_XZ = Matrix[[1, 0, 0], [0, -1, 0], [0, 0, 1]]
  REFLECT_IN_XY = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, -1]]

  def initialize(name)
    @name = name
    @beacons = { 'x0' => [] }
    @betweens = {}
  end

  # We assume Scanner 0 is correct, and that each other scanner "could be in any of 24 different orientations: facing positive or negative x, y, or z, and considering
  # any of four directions "up" from that facing."
  def do_all_transformations
    do_rotations('x', NINETY_AROUND_X_CCW, @beacons['x0'])
    do_reflection('x', REFLECT_IN_YZ, @beacons['x0'])
    do_rotations('-x', NINETY_AROUND_X_CCW, @beacons['-x0'])

    do_rotations('y', NINETY_AROUND_Y_CCW, @beacons['x0'])
    do_reflection('y', REFLECT_IN_XZ, @beacons['x0'])
    do_rotations('-y', NINETY_AROUND_X_CCW, @beacons['-y0'])

    do_rotations('z', NINETY_AROUND_Z_CCW, @beacons['x0'])
    do_reflection('z', REFLECT_IN_XY, @beacons['x0'])
    do_rotations('-z', NINETY_AROUND_Z_CCW, @beacons['-z0'])

    # TODO: I can see 18 possible transformations, @ericwastl says it is 24.
  end

  def do_rotations(axis, matrix, beacons)
    new_beacons = beacons.clone
    %w[90 180 270].each do |r_str|
      new_beacons = new_beacons.map { |b| transform_beacon(matrix, b) }
      @beacons["#{axis}#{r_str}"] = new_beacons
    end
  end

  def do_reflection(axis, matrix, beacons)
    @beacons["-#{axis}0"] = beacons.map { |b| transform_beacon(matrix, b) }
  end

  def transform_beacon(matrix, beacon)
    (matrix * Vector[*beacon]).to_a
  end

  def build_vectors
    @beacons.each_key do |k|
      @betweens[k] = calc_betweens(@beacons[k])
    end
  end
end

def report(filename)
  # lines = File.read_
end
