# frozen_string_literal: true

require './day18'
using ToSN

# https://adventofcode.com/2021/day/17
RSpec.describe String do
  describe '#to_sn' do
    it 'correctly parses a snailfish number string' do
      sn_string = '[[1,2],3]'
      sn = sn_string.to_sn
      expect(sn.pair[0].parent).to eq(sn)
      expect(sn.pair[1].parent).to eq(sn)
      expect(sn.pair[0].pair[0].parent).to eq(sn.pair[0])
      expect(sn.pair[0].pair[1].parent).to eq(sn.pair[0])
      expect(sn.pair[1].pair).to be_nil
      expect(sn.pair[1].number).to eq(3)
      expect(sn.pair[0].pair[0].pair).to be_nil
      expect(sn.pair[0].pair[0].number).to eq(1)
      expect(sn.pair[0].pair[1].pair).to be_nil
      expect(sn.pair[0].pair[1].number).to eq(2)
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
