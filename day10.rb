# frozen_string_literal: true

# https://adventofcode.com/2021/day/10
class Checker
  attr_accessor :loc, :illegal_char_scores, :autocomplete_char_scores, :opening_brackets, :opening_to_closing,
                :closing_brackets, :closing_to_opening

  def initialize(input_data_filename)
    @loc = File.readlines(input_data_filename).map(&:chomp)
    @illegal_char_scores = { ')' => 3, ']' => 57, '}' => 1_197, '>' => 25_137, false => 0 }
    @autocomplete_char_scores = { ')' => 1, ']' => 2, '}' => 3, '>' => 4, false => 0 }
    @opening_brackets = ['(', '[', '{', '<']
    @opening_to_closing = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    @closing_brackets = [')', ']', '}', '>']
    @closing_to_opening = { ')' => '(', ']' => '[', '}' => '{', '>' => '<' }
  end

  # Return the first illegal closing braket, if there is one
  def illegal(line)
    unclosed_brackets = []
    line.chars.each do |c|
      if opening_brackets.include? c
        unclosed_brackets << c
      else
        return c unless unclosed_brackets[-1] == closing_to_opening[c]

        unclosed_brackets.pop
      end
    end
    false
  end

  # Part 1
  def total_syntax_error_score
    loc.reduce(0) { |score, line| score + illegal_char_scores[illegal(line)] }
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = Checker.new('day10-input-test.txt')
puts "The total syntax error score is #{data.total_syntax_error_score}"
puts "\nFull dataset:"
data = Checker.new('day10-input-01.txt')
puts "The total syntax error score is #{data.total_syntax_error_score}"
