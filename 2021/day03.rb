# frozen_string_literal: true

DigitCounts = Struct.new(:one_counts, :zero_counts)

DIAGNOSTIC_LENGTH = File.open('../inputs/2021/day03-input-01.txt', &:readline).chomp().length
diagnostics = File.readlines('../inputs/2021/day03-input-01.txt').map { |reading| reading.to_i(2) }

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

# counts = digit_counts
# oxygen_candidates = diagnostics
# (0...DIAGNOSTIC_LENGTH).each do |i|
#   if counts.one_counts[i] >= counts.zero_counts[i]
#     oxygen_candidates = oxygen_candidates.select do |diagnostic|
#       diagnostic & (((2**(DIAGNOSTIC_LENGTH - i)) - 1)) >= (2**(DIAGNOSTIC_LENGTH - (i + 1)))
#     end
#   else
#     oxygen_candidates = oxygen_candidates.select do |diagnostic|
#       diagnostic & (((2**(DIAGNOSTIC_LENGTH - i)) - 1)) < (2**(DIAGNOSTIC_LENGTH - (i + 1)))
#     end
#   end
#   break if oxygen_candidates.length == 1

#   counts = count_digits(oxygen_candidates)
# end

# counts = digit_counts
# scrubber_candidates = diagnostics
# (0...DIAGNOSTIC_LENGTH).each do |i|
#   if counts.one_counts[i] < counts.zero_counts[i]
#     scrubber_candidates = scrubber_candidates.select do |diagnostic|
#       diagnostic & (((2**(DIAGNOSTIC_LENGTH - i)) - 1)) >= (2**(DIAGNOSTIC_LENGTH - (i + 1)))
#     end
#   else
#     scrubber_candidates = scrubber_candidates.select do |diagnostic|
#       diagnostic & (((2**(DIAGNOSTIC_LENGTH - i)) - 1)) < (2**(DIAGNOSTIC_LENGTH - (i + 1)))
#     end
#   end
#   break if scrubber_candidates.length == 1

#   counts = count_digits(scrubber_candidates)
# end

# puts "oxygen (#{oxygen_candidates[0]}) * oxygen (#{scrubber_candidates[0]}) = #{oxygen_candidates[0] * scrubber_candidates[0]}"

# Let me try brute force in text :-(

diagnostic_strings = File.readlines('../inputs/2021/day03-input-01.txt')
oxygen_strings = scrubber_strings = diagnostic_strings

(0...12).each do |i|
  if oxygen_strings.length > 1
    ones_count = oxygen_strings.count { |d| d[i] == '1' }
    zeros_count = oxygen_strings.count { |d| d[i] == '0' }
    if ones_count >= zeros_count
      oxygen_strings = oxygen_strings.select { |d| d[i] == '1' }
    else
      oxygen_strings = oxygen_strings.select { |d| d[i] == '0' }
    end
  end
  if scrubber_strings.length > 1
    ones_count = scrubber_strings.count { |d| d[i] == '1' }
    zeros_count = scrubber_strings.count { |d| d[i] == '0' }
    if ones_count < zeros_count
      scrubber_strings = scrubber_strings.select { |d| d[i] == '1' }
    else
      scrubber_strings = scrubber_strings.select { |d| d[i] == '0' }
    end
  end
end
puts oxygen_strings
puts scrubber_strings
puts oxygen_strings[0].to_i(2) * scrubber_strings[0].to_i(2)
