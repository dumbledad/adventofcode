# frozen_string_literal: true

# https://adventofcode.com/2021/day/13
class Paper
  attr_accessor :dots, :folds, :max_x, :max_y

  def initialize(input_data_filename)
    lines = File.readlines(input_data_filename).map(&:chomp)
    initialize_dots(lines)
    initialize_folds(lines)
    initialize_maxes
  end

  def initialize_dots(lines)
    @dots = lines.select { |l| l =~ /^\d/ }.map { |l| l.split(',').map(&:to_i) }
  end

  def initialize_folds(lines)
    @folds = lines.select { |l| l.start_with?('f') }.map { |l| l.sub('fold along ', '').split('=') }.map do |f|
      f[0] == 'x' ? [f[1].to_i, 0] : [0, f[1].to_i]
    end
  end

  def initialize_maxes
    @max_x = @dots.map { |d| d[0] }.max
    @max_y = @dots.map { |d| d[1] }.max
  end

  def print_grid
    rows = []
    (0..@max_y).each do
      rows << (0..@max_x).map { |_| '.' }
    end
    @dots.each do |d|
      rows[d[1]][d[0]] = '#'
    end
    rows.each do |row|
      puts row.join
    end
  end

  def fold_along(fold)
    return horizontal_fold(fold[1]) if fold[0].zero?
    return vertical_fold(fold[0]) if fold[1].zero?
  end

  def horizontal_fold(at_y)
    @dots = @dots.map { |dot| [dot[0], dot[1] < at_y ? dot[1] : at_y - (dot[1] - at_y)] }.uniq
    initialize_maxes
  end

  def vertical_fold(at_x)
    @dots = @dots.map { |dot| [dot[0] < at_x ? dot[0] : at_x - (dot[0] - at_x), dot[1]] }.uniq
    initialize_maxes
  end
end

def part_one(filename)
  data = Paper.new(filename)
  data.fold_along(data.folds[0])
  puts "After the first fold there are #{data.dots.length} dots (from #{filename})"
end

['day13-input-test.txt', 'day13-input-01.txt'].each { |f| part_one(f) }

def part_two(filename)
  data = Paper.new(filename)
  data.folds.each { |fold| data.fold_along(fold) }
  data.print_grid
end

['day13-input-test.txt', 'day13-input-01.txt'].each { |f| part_two(f) }
