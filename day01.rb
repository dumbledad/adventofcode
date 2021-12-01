# frozen_string_literal: true

depth_readings = File.readlines('day01-input-01.txt').map(&:to_i)
accumulated = depth_readings.reduce([0, 0]) do |accumulator, depth|
  [accumulator[0] + (depth > accumulator[1] ? 1 : 0), depth]
end
puts accumulated[0] - 1
