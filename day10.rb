# frozen_string_literal: true

# https://adventofcode.com/2021/day/10
class Checker
  attr_accessor :loc, :illegal_char_scores, :opening_brackets, :closing_brackets, :closing_to_opening

  def initialize(input_data_filename)
    @loc = File.readlines(input_data_filename).map(&:chomp)
    @illegal_char_scores = {
      ')' => 3,
      ']' => 57,
      '}' => 1_197,
      '>' => 25_137,
      false => 0
    }
    @opening_brackets = ['(', '[', '{', '<']
    @closing_brackets = [')', ']', '}', '>']
    @closing_to_opening = {
      ')' => '(',
      ']' => '[',
      '}' => '{',
      '>' => '<'
    }
  end

  def complete?(line)
    line.chars.count { |c| opening_brackets.include? c } == line.chars.count { |c| closing_brackets.include? c }
  end

  def complete_loc
    @complete_loc ||= loc.select { |l| complete? l }
  end

  def first_illegal_closing_bracket(line)
    chars = line.chars
    chunks = Hash.new(0)
    chars.each do |c|
      if opening_brackets.include? c
        chunks[c] += 1
        next
      elsif chunks[closing_to_opening[c]].positive?
        chunks[closing_to_opening[c]] -= 1
        next
      else # chunks[closing_to_opening[c]].zero?
        return c
      end
    end
    false
  end

  # Part 1
  def total_syntax_error_score
    sum = 0
    loc.each do |line|
      icb = first_illegal_closing_bracket(line)
      score = illegal_char_scores[icb]
      sum += score
    end
    # loc.reduce(0) { |sum, line| sum + illegal_char_scores[first_illegal_closing_bracket(line)] }
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = Checker.new('day10-input-test.txt')
puts "The total syntax error score is #{data.total_syntax_error_score}"
# puts "\nFull dataset:"
# data = Checker.new('day10-input-01.txt')
# puts "The total syntax error score is #{data.total_syntax_error_score}"
