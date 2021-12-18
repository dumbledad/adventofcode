# frozen_string_literal: true

module ToSN
  refine String do
    def to_sn
      # No-op.
    end
  end
end

# https://adventofcode.com/2021/day/18
class SnailfishNumber
  using ToSN

  attr_accessor :pair, :parent

  def initialize(parent)
    @pair = [0, 0]
    @parent = parent
  end

  def +(other)
    add(other)
  end

  def add(other)
    # No-op.
  end
end
