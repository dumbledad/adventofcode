# frozen_string_literal: true

# https://adventofcode.com/2021/day/12
class Caves
  attr_accessor :links

  def initialize(input_data_filename)
    @links = {}
    File.readlines(input_data_filename).map(&:chomp).map { |l| l.split('-') }.each do |p|
      @links[p[0]] = [] unless @links.keys.include? p[0]
      @links[p[0]] = @links[p[0]] << p[1] unless @links[p[0]].include? p[1]
      @links[p[1]] = [] unless @links.keys.include? p[1]
      @links[p[1]] = @links[p[1]] << p[0] unless @links[p[1]].include? p[0]
    end
  end
end

data = Caves.new('day12-input-test.txt')
puts data.links
