# frozen_string_literal: true

# https://adventofcode.com/2021/day/14
class OptimalPolymerFormula
  attr_accessor :polymer_template, :polymer, :insertion_map

  def initialize(input_data_filename)
    @polymer_template = File.open(input_data_filename, &:readline).chomp
    @polymer = @polymer_template
    @insertion_map = initialize_insertions(File.readlines(input_data_filename).drop(2).map(&:chomp).map { |l| l.split(' -> ') })
  end

  def initialize_insertions(pairs)
    # pairs.each_with_object({}) { |p, h| h[p[0]] = p[0][0] + p[1] + p[0][1] }
    pairs.each_with_object({}) { |p, h| h[p[0]] = p[1] }
  end

  # Part 1: most common element (mce) minus least common element (lce)
  def mce_minus_lce_after(num_steps)
    do_steps(num_steps)
    tallies = @polymer.chars.tally
    mce = tallies.max_by { |_, v| v }[1]
    lce = tallies.min_by { |_, v| v }[1]
    mce - lce
  end

  def do_steps(num_steps)
    (0...num_steps).each { step }
  end

  def step
    insertions = (0...@polymer.length).map { |i| @insertion_map[@polymer[i, 2]] }.join
    @polymer = @polymer.chars.zip(insertions.chars).join
  end
end

def polymer(filename, steps)
  data = OptimalPolymerFormula.new(filename)
  puts "After #{steps} steps mce - lce = #{data.mce_minus_lce_after(steps)} (from #{filename})"
end

[10, 40].each { |s| ['day14-input-test.txt', 'day14-input-01.txt'].each { |f| polymer(f, s) } }
