# frozen_string_literal: true

require './day17'

# https://adventofcode.com/2021/day/17
RSpec.describe ProbeLauncher do
  description = 'target area: x=20..30, y=-10..-5'
  describe '#parse_target_description' do
    it 'correctly parses the target description string into [x_min, x_max, y_min, y_max] array' do
      launcher = ProbeLauncher.new
      target = launcher.parse_target_description(description)
      expect(target).to eq([20, 30, -10, -5])
    end
  end
  describe '#max_y_reached' do
    it 'correctly finds the maxumum y possible while still hitting target' do
      launcher = ProbeLauncher.new
      target = launcher.parse_target_description(description)
      launcher.target = target
      max_y = launcher.max_y_reached
      expect(max_y).to eq(45)
    end
  end
end
