# frozen_string_literal: true

##########
# PART 1 #
##########

# https://adventofcode.com/2021/day/4
class SquidBingo
  # One bingo board
  class BingoBoard
    attr_accessor :board, :calls

    def initialize
      @board = []
      @calls = []
    end

    def load(lines)
      lines.each do |line|
        @board << line.split.map(&:to_i)
      end
      self
    end

    def winner?
      rows_and_columns = @board + @board.transpose
      rows_and_columns.each do |numbers|
        return true if (numbers - @calls).length.zero?
      end
      false
    end

    def remaining
      @board.flatten.reject { |number| @calls.include? number }
    end
  end

  def run
    calls.each do |call|
      boards.each do |board|
        board.calls << call
        return { 'winner': board, 'score': board.remaining.sum * call } if board.winner?
      end
    end
    { 'winner': nil, 'score': -1 }
  end

  def calls
    @calls ||= File.open('day04-input-01.txt', &:readline).chomp.split(',').map(&:to_i)
  end

  def boards
    @boards ||= load_boards
  end

  private

  def load_boards
    accumulator = File.readlines('day04-input-01.txt').drop(2).map(&:chomp)\
                      .each_with_object({ 'lines': [], 'boards': [] }) do |line, memo|
      if line == ''
        memo[:boards] << BingoBoard.new.load(memo[:lines])
        memo[:lines] = []
      else
        memo[:lines] << line
      end
    end
    accumulator[:boards]
  end
end

puts SquidBingo.new.run
