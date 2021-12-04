# frozen_string_literal: true

# One bingo board
class BingoBoard
  attr_accessor :board, :calls, :winning_call, :winning_score, :winner

  def initialize
    @board = []
    @calls = []
    @winner = false
  end

  def load(lines)
    lines.each do |line|
      @board << line.split.map(&:to_i)
    end
    self
  end

  def add_call(call)
    @calls << call
    rows_and_columns = @board + @board.transpose
    rows_and_columns.each do |numbers|
      next unless (numbers - @calls).length.zero?

      @winning_call = call
      @winning_score = (@board.flatten - @calls).sum * call
      @winner = true
    end
    false
  end
end

# https://adventofcode.com/2021/day/4
class SquidBingo
  attr_accessor :winners

  def initialize
    @winners = []
    calls.each do |call|
      boards.each do |board|
        next if board.winner

        board.add_call call
        winners << board if board.winner
      end
    end
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

bingo_games = SquidBingo.new
puts bingo_games.winners[0].winning_score
puts bingo_games.winners[-1].winning_score
