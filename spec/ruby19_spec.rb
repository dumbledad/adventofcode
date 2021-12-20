# frozen_string_literal: true

require './day19'

# https://adventofcode.com/2021/day/19
RSpec.describe Sensor do
  describe '#do_rotations' do
    it 'correctly rotates a beacon around the x axis' do
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
      sensor.beacons['x0'] = beacons
      beacons_x0_before = sensor.beacons['x0'].clone
      sensor.do_rotations('x', Sensor::NINETY_AROUND_X_CCW, beacons)
      expect(sensor.beacons.keys).to include(*%w[x0 x90 x180 x270])
      expect(sensor.beacons.keys).not_to include(*%w[y0 y90 y180 y270 z0 z90 z180 z270])
      expect(sensor.beacons['x0']).to eq(beacons_x0_before)
      expect(sensor.beacons['x90']).to eq(
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
