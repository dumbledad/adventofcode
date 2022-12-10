# frozen_string_literal: true

# https://adventofcode.com/2021/day/10
class Checker
  attr_accessor :loc, :illegal_char_scores, :autocomplete_char_scores, :opening_brackets, :opening_to_closing,
                :closing_brackets, :closing_to_opening

  def initialize(input_data_filename)
    @loc = File.readlines(input_data_filename).map(&:chomp)
    @illegal_char_scores = { ')' => 3, ']' => 57, '}' => 1_197, '>' => 25_137, false => 0 }
    @autocomplete_char_scores = { ')' => 1, ']' => 2, '}' => 3, '>' => 4}
    @opening_brackets = ['('../inputs/2021/, '[', '{', '<']
    @opening_to_closing = { '('../inputs/2021/ => ')', '[' => ']', '{' => '}', '<' => '>' }
    @closing_brackets = [')', ']', '}', '>']
    @closing_to_opening = { ')' => '('../inputs/2021/, ']' => '[', '}' => '{', '>' => '<' }
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

  def autocomplete(line)
    unclosed_brackets = []
    line.chars.each do |c|
      if opening_brackets.include? c
        unclosed_brackets << c
      else
        return [] unless unclosed_brackets[-1] == closing_to_opening[c]

        unclosed_brackets.pop
      end
    end
    unclosed_brackets.map { |c| opening_to_closing[c] }.reverse
  end

  def autocomplete_score(line)
    score = 0
    autocomplete(line).each do |c|
      score *= 5
      score += autocomplete_char_scores[c]
    end
    score
  end

  # Part 2
  def middle_autocomplete_score
    scores = loc.map { |line| autocomplete_score(line) }.select(&:positive?).sort
    scores[scores.length / 2]
  end
end

puts "\nPART ONE"
puts "\nTest dataset:"
data = Checker.new('../inputs/2021/day10-input-test.txt')
puts "The total syntax error score is #{data.total_syntax_error_score}"
puts "\nFull dataset:"
data = Checker.new('../inputs/2021/day10-input-01.txt')
puts "The total syntax error score is #{data.total_syntax_error_score}"

puts "\nPART TWO"
puts "\nTest dataset:"
data = Checker.new('../inputs/2021/day10-input-test.txt')
puts "The middle autocomplete score is #{data.middle_autocomplete_score}"
puts "\nFull dataset:"
data = Checker.new('../inputs/2021/day10-input-01.txt')
puts "The middle autocomplete score is #{data.middle_autocomplete_score}"
