# frozen_string_literal: true

# https://adventofcode.com/2021/day/19
class Sensors
  attr_accessor :sensors

  def initialize(input_data_filename)
    @sensors = []
    sensor = nil
    lines = File.readlines(input_data_filename).map(&:chomp)
    lines.each do |line|
      if line.start_with? '---'
        digit = line.match(/\d+/)[0]
        sensor = Sensor.new(digit)
        @sensors << sensor
      elsif line.length.positive?
        sensor.beacons['initial'] = [] unless sensor.beacons.keys.include? 'initial'
        sensor.beacons['initial'] << [*line.split(',').map(&:to_i)]
      end
    end
    @sensors.each do |s|
      s.do_all_transformations(s.beacons['initial'])
      s.beacons.delete('initial')
      s.build_vectors
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
      beacons.drop(i + 1).each do |b2|
        min_b, max_b = order(b1, b2)
        vectors_between << (Vector[*max_b] - Vector[*min_b]).to_a
      end
    end
    vectors_between
  end

  # A stable ordering between beacons. Any ordering will do as we are only using it to make sure we do not need to store and compare both A -> B and B -> A.
  def order(beacon1, beacon2)
    [beacon1, beacon2].sort_by { |b| [b[0], b[1], b[2]] }
  end

  def overlap(other)
    overlaps = []
    @betweens.each_key do |k1|
      other.betweens.each_key do |k2|
        overlaps << [@betweens[k1].intersection(other.betweens[k2]).size, k1, k2]
      end
    end
    overlaps.max_by { |o| o[0] }
  end
end

def report(filename)
  sensors = Sensors.new(filename)
  sensors.sensors.each_with_index do |s1, i|
    sensors.sensors.drop(i + 1).each do |s2|
      overlap = s1.overlap(s2)
      puts "Overlap between #{s1.name} and #{s2.name} is #{overlap[0]} between transformations #{overlap[1]} and #{overlap[2]}"
    end
  end
end

report('day19-input-test.txt') if __FILE__ == $PROGRAM_NAME
