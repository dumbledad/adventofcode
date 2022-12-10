require 'date'

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

  def initialize_insertions(insertion_pairs)
    insertion_pairs.each_with_object({}) { |p, h| h[p[0]] = [p[0][0] + p[1], p[1] + p[0][1]] }
  end

  # Part 1: most common element (mce) minus least common element (lce)
  def mce_minus_lce_after(num_steps)
    do_steps(num_steps)
    tallies = tally_elements
    mce = tallies.max_by { |_, v| v }[1]
    lce = tallies.min_by { |_, v| v }[1]
    mce - lce
  end

  def tally_elements
    tallies = @pair_counts.each_with_object(Hash.new { 0 }) do |p, c|
      c[p[0][1]] += p[1]
    end
    tallies[@template[0]] += 1
    tallies
  end

  def do_steps(num_steps)
    (0...num_steps).each { step }
  end

  def step
    replacement = Hash.new { 0 }
    @pair_counts.each do |old_p, c|
      @insertion_map[old_p].each do |new_p|
        replacement[new_p] += c
      end
    end
    @pair_counts = replacement
  end
end

def polymer(filename, steps)
  data = OptimalPolymerFormula.new(filename)
  puts "\nAfter #{steps} steps mce - lce = #{data.mce_minus_lce_after(steps)} (from #{filename})"
end

[10, 40].each { |s| ['day14-input-test.txt', 'day14-input-01.txt'].each { |f| polymer(f, s) } }
