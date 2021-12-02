# frozen_string_literal: true

course_readings = File.readlines('day02-input-01.txt').map do |line| 
  split_line = line.split
  [split_line[0], split_line[1].to_i]
end

def sum_commands(command, input_array)
  input_array.reduce(0) do |accumulation, command_value|
    accumulation + (command_value[0] == command ? command_value[1] : 0)
  end
end

forward = sum_commands('forward', course_readings)
down = sum_commands('down', course_readings)
up = sum_commands('up', course_readings)
depth = down - up

puts "Our new position is #{forward} forward at #{depth} depth, which multiply to give #{forward * depth}"
