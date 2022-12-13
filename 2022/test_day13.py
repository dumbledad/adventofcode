from day13 import Packets

filename = 'inputs/2022/day13-test.txt'

def test_packets_init():
  packets = Packets(filename)
  assert packets.data
