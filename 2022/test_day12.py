from day12 import Dijkstra, Hill

filename = 'inputs/2022/day12-test.txt'

def test_hill_init():
  hill = Hill('S')
  assert hill.height == ord('a')
  assert hill.start
  assert not hill.end
  hill = Hill('E')
  assert hill.height == ord('z')
  assert not hill.start
  assert hill.end
  hill = Hill('g')
  assert hill.height == ord('g')
  assert not hill.start
  assert not hill.end

def test_dijkstra_init():
  dijkstra = Dijkstra(filename)
  assert dijkstra.data
