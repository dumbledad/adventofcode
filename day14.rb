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
    added = @pair_counts.keys.each_with_object([]) do |p, a|
      (0...@pair_counts[p]).each do
        a.concat @insertion_map[p]
      end
    end
    @pair_counts = added.tally
  end
end

def polymer(filename, steps)
  data = OptimalPolymerFormula.new(filename)
  before = DateTime.now
  puts "\nAfter #{steps} steps mce - lce = #{data.mce_minus_lce_after(steps)} (from #{filename})"
  after = DateTime.now
  puts "That took from #{before} to #{after}, i.e. #{(after - before).to_i} seconds\n"
end

[10, 40].each { |s| ['day14-input-test.txt', 'day14-input-01.txt'].each { |f| polymer(f, s) } }
