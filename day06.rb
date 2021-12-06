# frozen_string_literal: true

# https://adventofcode.com/2021/day/6

# Part 2, blows up so I cannot use the same approach.
# For reference the Part 1 code is here: https://github.com/dumbledad/adventofcode2021/blob/1f5ab03af36a0ac686f1d63c6e5eeeefea7dedde/day06.rb

# A shoal of lanternfish
class Shoal
  attr_accessor :fisheses, :days_of_interest, :days_to_spawn, :immaturity, :day

  def initialize(input_data_filename, days_of_interest)
    @fisheses = File.open(input_data_filename, &:readline).chomp.split(',').map(&:to_i).tally
    @days_of_interest = days_of_interest
    @days_to_spawn = 7
    @immaturity = 2
    @day = 0
  end

  def progress(days)
    days.times { progress_one_day }
  end

  def progress_one_day
    @day += 1
    after = (0..@days_to_spawn + @immaturity).to_h { |i| [i, 0] }
    (1..(@days_to_spawn + @immaturity)).each { |d| after[d - 1] = @fisheses[d] if @fisheses.key? d }
    @fisheses[0] = 0 if @fisheses[0].nil?
    after[@days_to_spawn - 1] = after[@days_to_spawn - 1] + @fisheses[0]
    after[@days_to_spawn + @immaturity - 1] = @fisheses[0]
    @fisheses = after
    puts "After #{@day} days the shoal contains #{@fisheses.values.sum} lanternfish" if @days_of_interest.include? @day
  end
end

shoal = Shoal.new('day06-input-test.txt', [80, 256])
shoal.progress(256)
