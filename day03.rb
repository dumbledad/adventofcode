# frozen_string_literal: true

diagnostic_length = File.open('day03-input-01.txt', &:readline).chomp().length
diagnostics = File.readlines('day03-input-01.txt').map { |reading| reading.to_i(2) }

##########
# PART 1 #
##########

DigitCounts = Struct.new(:one_counts, :zero_counts)
digit_counts = DigitCounts.new(Array.new(diagnostic_length, 0), Array.new(diagnostic_length, 0))

(0...diagnostic_length).each do |i|
  diagnostics.each do |diagnostic|
    if ((diagnostic >> i) & 1) == 1
      digit_counts.one_counts[i] += 1
    else
      digit_counts.zero_counts[i] += 1
    end
  end
end

gamma_str = epsilon_str = ''
(0...diagnostic_length).each do |i|
  if digit_counts.one_counts[i] > digit_counts.zero_counts[i]
    gamma_str = "1#{gamma_str}"
    epsilon_str = "0#{epsilon_str}"
  else
    gamma_str = "0#{gamma_str}"
    epsilon_str = "1#{epsilon_str}"
  end
end

puts "the power consumption of the submarine is #{gamma_str.to_i(2) * epsilon_str.to_i(2)}"
