# frozen_string_literal: true

require './day16'

# https://adventofcode.com/2021/day/16
RSpec.describe Transmission do
  describe '#drop_top_bits' do
    it 'correctly removes first three bits from 11010110001010 (13,706) to get 10110001010 (1,418)' do
      data = Transmission.new
      dropped = data.drop_top_bits(3, 13_706)
      expect(dropped).to eq(1_418)
    end
  end

  describe '#sum_version_numbers' do
    it 'correctly sums the version numbers of packets in a given packet' do
      data = Transmission.new
      [
        ['8A004A801A8002F478', 16],
        ['620080001611562C8802118E34', 12],
        ['C0015000016115A2E0802F182340', 23],
        ['A0016C880162017C3686B18A3D4780', 31]
      ].each do |packet_hex, version_sum|
        expect(data.sum_version_numbers(packet_hex)).to eq(version_sum)
      end
    end
  end
end
