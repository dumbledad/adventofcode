require 'set'

# frozen_string_literal: true

# https://adventofcode.com/2021/day/9
class ObservedData
  attr_accessor :readings, :size

  def initialize(input_data_filename)
    @readings = File.readlines(input_data_filename).map(&:chomp).map { |l| l.chars.map(&:to_i) }
    @size = [readings.length, readings[0].length]
  end

  def minima
    min = []
    readings.each_index do |i|
      readings[i].each_index do |j|
        min << readings[i][j] if readings[i][j] < adjacents(i, j).min
      end
    end
    min
  end

  def risk_levels
    minima.map { |m| m + 1 }
  end

  def adjacents(i_index, j_index)
    adjacent_indexes(i_index, j_index).map { |p| readings[p[0]][p[1]] }
  end

  def adjacent_indexes(i_index, j_index)
    adj = []
    adj << [i_index - 1, j_index] if i_index.positive?
    adj << [i_index, j_index - 1] if j_index.positive?
    adj << [i_index + 1, j_index] if i_index + 1 < size[0]
    adj << [i_index, j_index + 1] if j_index + 1 < size[1]
    adj
  end

  # def basins
  #   basins = Set[]
  #   readings.each_index do |i|
  #     readings[i].each_index do |j|

  # end

  # def add_non_nine_connecteds(i_index, j_index, basin)
  #   adjacents(i_index, j_index).each do |a|
  #     if 
  #   return [connected, checked << [i, j]] if readings[i][j] == 9
  # end
end

data = ObservedData.new('day09-input-test.txt')
puts data.risk_levels.sum

data = ObservedData.new('day09-input-01.txt')
puts data.risk_levels.sum
