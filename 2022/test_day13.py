from day13 import Packets

filename = 'inputs/2022/day13-test.txt'

def test_packets_init():
  packets = Packets(filename)
  assert packets.data
  assert len(packets.potentials) == 8

def test_packets_right_indexes():
  packets = Packets(filename)
  assert list(packets.correct_indexes) == [1, 2, 4, 6]
