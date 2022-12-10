# frozen_string_literal: true

require './day19'

# https://adventofcode.com/2021/day/19

RSpec.describe Sensors do
  describe '#initialize' do
    it 'Reads in 5 sensors' do
      sensors = Sensors.new('day19-input-test.txt')
      expect(sensors.sensors.length).to eq(5)
    end
  end
end

RSpec.describe Sensor do
  describe '#do_all_transformations' do
    sensor = Sensor.new('0')
    beacons =
      [
        [0.5, 0.5, 0.5],
        [-0.5, 0.5, 0.5],
        [0.5, -0.5, 0.5],
        [0.5, 0.5, -0.5],
        [-0.5, -0.5, 0.5],
        [-0.5, 0.5, -0.5],
        [0.5, -0.5, -0.5],
        [-0.5, -0.5, -0.5]
      ]
    sensor.do_all_transformations(beacons)
    it 'produces 24 transformations as mentioned in AOC 2021 Day 19, i.e. facing down each axis (x, -x, y, -y, z, -z) with any of the remaining 4 as up.' do
      expect(sensor.beacons.keys.length).to eq(24)
    end
    it 'correctly rotates by 90 CCW around x' do
      expect(sensor.beacons['0_1']).to eq(
        [
          [0.5, -0.5, 0.5],
          [-0.5, -0.5, 0.5],
          [0.5, -0.5, -0.5],
          [0.5, 0.5, 0.5],
          [-0.5, -0.5, -0.5],
          [-0.5, 0.5, 0.5],
          [0.5, 0.5, -0.5],
          [-0.5, 0.5, -0.5]
        ]
      )
    end
  end
end
