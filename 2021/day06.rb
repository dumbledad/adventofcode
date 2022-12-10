# frozen_string_literal: true

# https://adventofcode.com/2021/day/6

# Part 2, blows up so I cannot use the same approach.
# For reference the Part 1 code is here: https://github.com/dumbledad/adventofcode2021/blob/1f5ab03af36a0ac686f1d63c6e5eeeefea7dedde/day06.rb

# A shoal of lanternfish
class Shoal
  attr_accessor :fisheses, :days_of_interest, :days_to_spawn, :immaturity, :day

  def initialize(input_data_filename, days_of_interest)
    tally = File.open(input_data_filename, &:readline).chomp.split('../inputs/2021/,').map(&:to_i).tally
    @days_of_interest = days_of_interest
    @days_to_spawn = 7
    @immaturity = 2
    @day = 0
    @fisheses = Hash.new(0)
    (1..(@days_to_spawn + @immaturity)).each { |d| @fisheses[d] = tally.fetch(d, 0) }
  end

  def progress(days)
    days.times { progress_one_day }
  end

  def progress_one_day
    # Patrick:
    # Could us transform_keys or realise that a hash with continuous integer keys is better done as an array
    after = Hash.new(0)
    (1..(@days_to_spawn + @immaturity)).each { |d| after[d - 1] = @fisheses[d] }
    after[@days_to_spawn - 1] = after[@days_to_spawn - 1] + @fisheses[0]
    after[@days_to_spawn + @immaturity - 1] = @fisheses[0]
    @fisheses = after
    return unless @days_of_interest.include? @day += 1

    puts "After #{@day} days the shoal contains #{@fisheses.values.sum} lanternfish"
  end
end

puts "\nTest dataset:"
shoal = Shoal.new('../inputs/2021/day06-input-test.txt', [80, 256])
shoal.progress(256)
puts "\nFull dataset:"
shoal = Shoal.new('../inputs/2021/day06-input-01.txt', [80, 256])
shoal.progress(256)
puts ''
