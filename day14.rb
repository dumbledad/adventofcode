# frozen_string_literal: true

# https://adventofcode.com/2021/day/14
class OptimalPolymerFormula
  attr_accessor :polymer_template, :polymer, :insertions

  def initialize(input_data_filename)
    @polymer_template = File.open(input_data_filename, &:readline).chomp
    @polymer = @polymer_template
    @insertions = initialize_insertions(File.readlines(input_data_filename).drop(2).map(&:chomp).map { |l| l.split(' -> ') })
  end

  def initialize_insertions(pairs)
    pairs.each_with_object({}) { |p, h| h[p[0]] = p[0][0] + p[1] + p[0][1] }
  end

  # def step
  #   @polymer = (0...@polymer.length).map { |i| @polymer}
  # end
end

data = OptimalPolymerFormula.new('day14-input-test.txt')
pp data.insertions
puts data.polymer
