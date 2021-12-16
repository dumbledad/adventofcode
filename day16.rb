# frozen_string_literal: true

# https://adventofcode.com/2021/day/16
class Transmission
  attr_accessor :risks, :i_length, :j_length

  def initialize(input_data_filename, expand: false)
    @risks = File.readlines(input_data_filename).map(&:chomp).map(&:chars).map { |r| r.map(&:to_i) }
    @risks = expand_risks if expand
    @i_length = @risks.length
    @j_length = @risks[0].length
  end
end

def path(filename, expand)
  data = Chitons.new(filename, expand: expand)
  msg = expand ? ' expanded' : ''
  puts "The lowest risk path has #{data.dijkstra} risk (#{filename}#{msg})"
end

[false, true].each { |e| ['day15-input-test.txt', 'day15-input-01.txt'].each { |f| path(f, e) } }

16
12
23
31
