# frozen_string_literal: true

# https://adventofcode.com/2021/day/11
class DumboOctopuses
  attr_accessor :levels, :steps, :flashes, :i_length, :j_length, :flash_above

  def initialize(input_data_filename)
    @levels = File.readlines(input_data_filename).map(&:chomp).map { |l| l.chars.map(&:to_i) }
    @steps = 100
    @flashes = 0
    @i_length = levels.length
    @j_length = levels[0].length
    @flash_above = 9
  end

  def print_levels
    @levels.each_index { |i| @levels.each_index { |j| puts("((#{i}, #{j}), #{@levels[i][j]})") } }
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
    flashed = []
    until (to_flash - flashed.uniq).empty?
      (to_flash - flashed.uniq).each do |i_j|
        flash_at(i_j)
        flashed << i_j
      end
    end
    flashed = flashed.uniq
    @flashes += flashed.length
    flashed.each do |i_j|
      @levels[i_j[0]][i_j[1]] = 0
    end
  end

  def flash_at(i_j)
    adjacents(i_j).each do |adj|
      @level[adj[0]][adj[1]] += 1
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

data = DumboOctopuses.new('day11-input-test.txt')
data.do_steps
# puts "\nPART ONE"
# puts "\nTest dataset:"
# data = DumboOctopuses.new('day11-input-test.txt')
# puts "There were #{data.flashes} flashes after #{data.steps} steps"
# puts "\nFull dataset:"
# data = DumboOctopuses.new('day11-input-01.txt')
# puts "There were #{data.flashes} flashes after #{data.steps} steps"
