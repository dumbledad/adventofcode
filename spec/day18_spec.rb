# frozen_string_literal: true

require './day18'
using Refinements

# https://adventofcode.com/2021/day/17
RSpec.describe String do
  describe '#to_sn' do
    it 'correctly parses a snailfish number string' do
      sn_string = '[[1,2],3]'
      sn = sn_string.to_sn
      expect(sn.left.parent).to eq(sn)
      # 1
      expect(sn.left.left.parent).to eq(sn.left)
      expect(sn.left.left.left).to be_nil
      expect(sn.left.left.right).to be_nil
      expect(sn.left.left.value).to eq(1)
      # 2
      expect(sn.left.right.parent).to eq(sn.left)
      expect(sn.left.right.left).to be_nil
      expect(sn.left.right.right).to be_nil
      expect(sn.left.right.value).to eq(2)
      # 3
      expect(sn.right.parent).to eq(sn)
      expect(sn.right.left).to be_nil
      expect(sn.right.right).to be_nil
      expect(sn.right.value).to eq(3)
    end
  end
end

RSpec.describe SnailfishNumber do
  description = 'target area: x=20..30, y=-10..-5'
  describe '#parse_target_description' do
    it 'correctly parses the target description string into [x_min, x_max, y_min, y_max] array' do
      launcher = ProbeLauncher.new(description)
      expect(launcher.target).to eq([20, 30, -10, -5])
    end
  end
end
