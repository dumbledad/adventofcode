# frozen_string_literal: true

require './day18'

# https://adventofcode.com/2021/day/17
RSpec.describe SnailfishNumber do
  description = 'target area: x=20..30, y=-10..-5'
  describe '#parse_target_description' do
    it 'correctly parses the target description string into [x_min, x_max, y_min, y_max] array' do
      launcher = ProbeLauncher.new(description)
      expect(launcher.target).to eq([20, 30, -10, -5])
    end
  end
end
