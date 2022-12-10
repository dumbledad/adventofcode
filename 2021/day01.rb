# frozen_string_literal: true

depth_readings = File.readlines('../inputs/2021/day01-input-01.txt').map(&:to_i)

def num_increases(input_array)
  input_array.each_cons(2).reduce(0) { |count, values| count + (values[1] > values[0] ? 1 : 0) }
end

##########
# PART 1 #
##########

puts "Depth increase count: #{num_increases depth_readings}"

##########
# PART 2 #
##########

three_sum_depth_readings = depth_readings.each_cons(3).map(&:sum)
puts "3-sum depth increase count: #{num_increases three_sum_depth_readings}"
