# frozen_string_literal: true

depth_readings = File.readlines('day01-input-01.txt').map(&:to_i)

def num_increases(input_array)
  accumulated = input_array.reduce([0, 0]) do |accumulator, value|
    [accumulator[0] + (value > accumulator[1] ? 1 : 0), value]
  end
  accumulated[0] - 1
end

puts "Depth increase count: #{num_increases depth_readings}"

three_sum_depth_readings = depth_readings.each_cons(3).to_a.map(&:sum)
puts "3-sum depth increase count: #{num_increases three_sum_depth_readings}"
