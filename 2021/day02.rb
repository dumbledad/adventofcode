# frozen_string_literal: true

course_readings = File.readlines('../inputs/2021/day02-input-01.txt').map do |line|
  split_line = line.split
  [split_line[0], split_line[1].to_i]
end

##########
# PART 1 #
##########

def sum_commands(command, input_array)
  input_array.reduce(0) do |accumulation, command_value|
    accumulation + (command_value[0] == command ? command_value[1] : 0)
  end
end

forward = sum_commands('../inputs/2021/forward', course_readings)
down = sum_commands('../inputs/2021/down', course_readings)
up = sum_commands('../inputs/2021/up', course_readings)
depth = down - up

puts "Our new position is #{forward} forward at #{depth} depth, which multiply to give #{forward * depth}"

##########
# PART 2 #
##########

aim = 0
depth = 0
horizontal_position = 0
course_readings.each do |command, value|
  case command
  when 'forward'
    horizontal_position += value
    depth += aim * value
  when 'up'
    aim -= value
  when 'down'
    aim += value
  end
end

puts "Our new position is (#{depth}, #{horizontal_position}) i.e. #{depth * horizontal_position}"
