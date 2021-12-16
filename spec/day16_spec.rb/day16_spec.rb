# frozen_string_literal: true

require './day16'

RSpec.describe Transmission do
  describe '#drop_top_bits' do
    it 'correctly removes first three bits from 11010110001010 (13,706) to get 10110001010 (1,418)' do
      data = Transmission.new
      dropped = data.drop_top_bits(3, 13_706)
      expect(dropped).to eq(1_418)
    end
  end
end
