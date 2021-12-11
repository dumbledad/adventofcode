require 'set'

# frozen_string_literal: true

# https://adventofcode.com/2021/day/11
class DumboOctopuses
  attr_accessor :levels, :steps, :i_length, :j_length, :flash_above, :flashes_per_step

  def initialize(input_data_filename)
    initialize_constants
    initialize_data(input_data_filename)
    @flashes_per_step = []
  end

  def initialize_constants
    @steps = 100
    @flash_above = 9
  end

  def initialize_data(input_data_filename)
    @levels = File.readlines(input_data_filename).map(&:chomp).map { |l| l.chars.map(&:to_i) }
    @i_length = levels.length
    @j_length = levels[0].length
  end

  def octopi_count
    @octopi_count ||= levels.length * levels[0].length
  end

  def flashes
    @flashes_per_step.sum
  end

  def print_levels
    @levels.each { |row| puts row.join }
  end

  def to_flash
    to_flash = []
    @levels.each_index { |i| @levels.each_index { |j| to_flash << [i, j] if @levels[i][j] > @flash_above } }
    to_flash
  end

  def do_steps
    (1..@steps).each do
      do_step
    end
  end

  def do_step
    # Now I need @levels, previous days just levels. What's that about?
    @levels = @levels.each.map { |r| r.each.map { |l| l + 1 } }
    clear(flash)
  end

  def flash
    flashed = Set.new
    left_to_flash = to_flash - flashed.to_a
    until left_to_flash.empty?
      left_to_flash.each do |ij|
        flash_at(ij)
        flashed << ij
      end
      left_to_flash = to_flash - flashed.to_a
    end
    flashed
  end

  def flash_at(i_j)
    adjacents(i_j).each do |adj|
      @levels[adj[0]][adj[1]] += 1
    end
  end

  def clear(flashed)
    @flashes_per_step << flashed.length
    flashed.each do |ij|
      @levels[ij[0]][ij[1]] = 0
    end
  end

  def adjacents(i_j)
    adj = []
    ((i_j[0] - 1)..(i_j[0] + 1)).each do |i|
      ((i_j[1] - 1)..(i_j[1] + 1)).each do |j|
        adj << [i, j] if i >= 0 && j >= 0 && i < @i_length && j < @j_length
      end
    end
    adj
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = DumboOctopuses.new('day11-input-test.txt')
data.do_steps
puts "There were #{data.flashes} flashes after #{data.steps} steps"
puts "\nFull dataset:"
data = DumboOctopuses.new('day11-input-01.txt')
data.do_steps
puts "There were #{data.flashes} flashes after #{data.steps} steps"

# puts "\nPART TWO"
# puts "\nTest dataset:"
# data = DumboOctopuses.new('day11-input-test.txt')
# data.do_steps
# puts "There were #{data.flashes} flashes after #{data.steps} steps"
# puts "\nFull dataset:"
# data = DumboOctopuses.new('day11-input-01.txt')
# data.do_steps
# puts "There were #{data.flashes} flashes after #{data.steps} steps"