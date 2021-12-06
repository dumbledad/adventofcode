# frozen_string_literal: true

# https://adventofcode.com/2021/day/6

# A lanternfish that mainly spawns a single offspring every seventh day
class Lanternfish
  attr_accessor :day, :create_after

  def initialize(day)
    @day = day
    @create_after = 7
  end

  def progress
    @day -= @day
    return [self] unless @day == -1

    @day = @create_after - 1
    [self, Lanternfish.new(@create_after + 1)]
  end
end

# A shoal of lanternfish
class Shoal
  attr_accessor :fisheses

  def initialize
    @fisheses = File.open('day06-input-test.txt', &:readline).chomp.split(',').map { |d| Lanternfish.new(d.to_i) }
  end

  def progress
    after = []
    @fisheses.each_with_object(after) do |lf, a|
      lf.progress.each do |f|
        a << f
      end
    end
    @fisheses = after
  end
end

shoal = Shoal.new
days = 80
days.times { shoal.progress }
puts "After #{days} days the shoal contains #{shoal.fisheses.length} lanternfish"
