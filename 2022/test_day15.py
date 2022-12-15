from day15 import Tunnels

filename = 'inputs/2022/day15-test.txt'

def test_init():
  tunnels = Tunnels(filename)
  assert tunnels.data
  assert tunnels.sensors[4]['distance'] == 4
  assert tunnels.bounds['min_x'] == -2
  assert tunnels.bounds['max_x'] == 25
  assert tunnels.bounds['min_y'] == 0
  assert tunnels.bounds['max_y'] == 22

def test_impossible_count():
  tunnels = Tunnels(filename)
  assert tunnels.impossible_count(10) == 26

def test_distress_tuning():
  tunnels = Tunnels(filename)
  assert tunnels.distress_tuning() == 56_000_011
