# frozen_string_literal: true

# https://adventofcode.com/2021/day/14
class OptimalPolymerFormula
  attr_accessor :template, :polymer, :insertion_map

  def initialize(input_data_filename)
    @template = File.open(input_data_filename, &:readline).chomp
    @pair_counts = (0...@template.length - 1).each_with_object(Hash.new(0)) { |i, h| h[@template[i, 2]] += 1 }
    @insertion_map = initialize_insertions(
      File.readlines(input_data_filename).drop(2).map(&:chomp).map { |l| l.split(' -> ') }
    )
  end
