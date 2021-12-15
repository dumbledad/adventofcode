# frozen_string_literal: true

# https://adventofcode.com/2021/day/15
class Chitons
  attr_accessor :risks, :paths, :i_length, :j_length, :lowest_risk, :lowest_risk_path

  def initialize(input_data_filename)
    @risks = File.readlines(input_data_filename).map(&:chomp).map(&:chars).map { |r| r.map(&:to_i) }
    @paths = []
    @i_length = @risks.length
    @j_length = @risks[0].length
    add_initial_path
  end

  # First path is straight down from top left and then accross the bottom
  def add_initial_path
    path = []
    (0...@i_length).each { |i| path << [[i, 0], @risks[i][0]] }
    (0...@j_length).each { |j| path << [[0, j], @risks[0][j]] }
    @lowest_risk_path = path
    @lowest_risk = risk(path)
    @paths << path
  end

  # Calculate a path's risk (omitting the top left starting point as we leave it)
  def risk(path)
    (1...path.length).reduce(0) do |sum, i|
      sum + path[i][1]
    end
  end
end

def path(filename)
  data = Chitons.new(filename)
  puts "The lowest risk path has #{data.lowest_risk} risk (#{filename})"
end

['day15-input-test.txt'].each { |f| path(f) }
