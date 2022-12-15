from day15 import Tunnels

filename = 'inputs/2022/day15-test.txt'

def test_init():
  tunnels = Tunnels(filename)
  assert tunnels.data
  assert tunnels.sensors[4]['distance'] == 4
