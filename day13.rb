# frozen_string_literal: true

# https://adventofcode.com/2021/day/13
class Caves
  attr_accessor :links, :revisit_one_small

  def initialize(input_data_filename, revisit: false)
    @revisit_one_small = revisit
    @links = Hash.new { [] }
    File.readlines(input_data_filename).map(&:chomp).map { |l| l.split('-') }.each { |p| add_link(p) }
    paths
  end