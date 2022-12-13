from day13 import Packets

filename = 'inputs/2022/day13-test.txt'

def test_packets_init():
  packets = Packets(filename)
  assert packets.data
  assert len(packets.potentials) == 8

def test_packets_compare():
  assert Packets.compare([1,1,3,1,1], [1,1,5,1,1])
  assert Packets.compare([[1],[2,3,4]], [[1],4])
  assert not Packets.compare([9], [[8,7,6]])
  assert Packets.compare([[4,4],4,4], [[4,4],4,4,4])

def test_packets_right_indexes():
  packets = Packets(filename)
  assert list(packets.correct_indexes) == [1, 2, 4, 6]
