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
      sensor.do_all_transformations(line.split(',').map(&:to_i)) if line.length.positive?
    end
  end
end

class Sensor
  require 'matrix'

  attr_accessor :name, :beacons, :betweens

  # https://en.wikipedia.org/wiki/Rotation_matrix
  ZERO_AROUND_X_CCW = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
  ZERO_AROUND_Y_CCW = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
  ZERO_AROUND_Z_CCW = Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]]
  NINETY_AROUND_X_CCW = Matrix[[1, 0, 0], [0, 0, -1], [0, 1, 0]]
  NINETY_AROUND_Y_CCW = Matrix[[0, 0, 1], [0, 1, 0], [-1, 0, 0]]
  NINETY_AROUND_Z_CCW = Matrix[[0, -1, 0], [1, 0, 0], [0, 0, 1]]
  ONEEIGHTY_AROUND_X_CCW = Matrix[[1, 0, 0], [0, -1, 0], [0, 0, -1]]
  ONEEIGHTY_AROUND_Y_CCW = Matrix[[-1, 0, 0], [0, 1, 0], [0, 0, -1]]
  ONEEIGHTY_AROUND_Z_CCW = Matrix[[-1, 0, 0], [0, -1, 0], [0, 0, 1]]
  TWOSEVENTY_AROUND_X_CCW = Matrix[[1, 0, 0], [0, 0, 1], [0, -1, 0]]
  TWOSEVENTY_AROUND_Y_CCW = Matrix[[0, 0, -1], [0, 1, 0], [1, 0, 0]]
  TWOSEVENTY_AROUND_Z_CCW = Matrix[[0, 1, 0], [-1, 0, 0], [0, 0, 1]]
  X_CCWS = [ZERO_AROUND_X_CCW, NINETY_AROUND_X_CCW, ONEEIGHTY_AROUND_X_CCW, TWOSEVENTY_AROUND_X_CCW].freeze
  OTHER_CCWS =
    [
      ZERO_AROUND_Y_CCW,
      NINETY_AROUND_Y_CCW,
      ONEEIGHTY_AROUND_Y_CCW,
      TWOSEVENTY_AROUND_Y_CCW,
      NINETY_AROUND_Z_CCW,
      TWOSEVENTY_AROUND_Z_CCW
    ].freeze

  def initialize(name)
    @name = name
    @beacons = {}
    @betweens = {}
  end

  # We assume Scanner 0 is correct, and that each other scanner "could be in any of 24 different orientations: facing positive or negative x, y, or z, and considering
  # any of four directions "up" from that facing."
  def do_all_transformations(initial_beacons)
    OTHER_CCWS.each_with_index do |r1, i|
      X_CCWS.each_with_index do |r2, j|
        transformed_beacons = initial_beacons.map { |b| transform_beacon(r2 * r1, b) }
        @beacons["#{i}_#{j}"] = transformed_beacons
      end
    end
  end

  def transform_beacon(matrix, beacon)
    (matrix * Vector[*beacon]).to_a
  end

  def build_vectors
    @beacons.each_key do |k|
      @betweens[k] = calc_betweens(@beacons[k])
    end
  end

  def calc_betweens(beacons)
    vectors_between = []
    beacons.each_with_index do |b1, i|
      beacons.each_with_index do |b2, j|
        unless i == j
          min_b, max_b = order(b1, b2)
          vectors_between << [max_b[0] - min_b[0], max_b[1] - min_b[1], max_b[2] - min_b[2]]
        end
      end
    end
    vectors_between
  end

  # A stable ordering between beacons. Any ordering will do as we are only using it to make sure we do not need to store and compare both A -> B and B -> A.
  def order(beacon1, beacon2)
    [beacon1, beacon2].sort { |a, b| (a[0]**2 + a[1]**2 + a[2]**2) <=> (b[0]**2 + b[1]**2 + b[2]**2) }
  end
end

def report(filename)
  # lines = File.read_
end
