# frozen_string_literal: true

DigitCounts = Struct.new(:one_counts, :zero_counts)

DIAGNOSTIC_LENGTH = File.open('day03-input-01.txt', &:readline).chomp().length
diagnostics = File.readlines('day03-input-01.txt').map { |reading| reading.to_i(2) }

# rubocop:disable Metrics/MethodLength
def count_digits(input_diagnostics_array)
  digit_counts = DigitCounts.new(Array.new(DIAGNOSTIC_LENGTH, 0), Array.new(DIAGNOSTIC_LENGTH, 0))
  (0...DIAGNOSTIC_LENGTH).each do |i|
    input_diagnostics_array.each do |diagnostic|
      if ((diagnostic >> i) & 1) == 1
        digit_counts.one_counts[i] += 1
      else
        digit_counts.zero_counts[i] += 1
      end
    end
  end
  digit_counts
end
# rubocop:enable Metrics/MethodLength

##########
# PART 1 #
##########

gamma_str = epsilon_str = ''
digit_counts = count_digits(diagnostics)
(0...DIAGNOSTIC_LENGTH).each do |i|
  if digit_counts.one_counts[i] > digit_counts.zero_counts[i]
    gamma_str = "1#{gamma_str}"
    epsilon_str = "0#{epsilon_str}"
  else
    gamma_str = "0#{gamma_str}"
    epsilon_str = "1#{epsilon_str}"
  end
end

puts "the power consumption of the submarine is #{gamma_str.to_i(2) * epsilon_str.to_i(2)}"

##########
# PART 2 #
##########
