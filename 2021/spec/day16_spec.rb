# frozen_string_literal: true

require './day16'

# https://adventofcode.com/2021/day/16
RSpec.describe Transmission do
  describe '#parse_literal_value' do
    it 'correctly parses a literal value packet fragment' do
      transmission = Transmission.new
      literal_value = transmission.parse_literal_value('101111111000101000111')
      expect(literal_value).to eq([2021, '000111'])
    end
  end

  describe '#packet_to_bin' do
    it 'correctly converts a hex to a binary string' do
      transmission = Transmission.new
      bin_str = transmission.packet_to_bin('6FA0')
      expect(bin_str).to eq('0110111110100000')
    end
  end

  describe '#sum_version_numbers' do
    it 'correctly sums the version numbers of packets in a given packet' do
      transmission = Transmission.new
      [
        ['8A004A801A8002F478', 16],
        ['620080001611562C8802118E34', 12],
        ['C0015000016115A2E0802F182340', 23],
        ['A0016C880162017C3686B18A3D4780', 31]
      ].each do |packet_hex, version_sum|
        packet_bin = transmission.packet_to_bin(packet_hex)
        packet, = transmission.parse_packet(packet_bin)
        sum = transmission.sum_version_numbers(packet)
        expect(sum).to eq(version_sum)
      end
    end
  end
end
