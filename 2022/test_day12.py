from day12 import Dijkstra, Hill
import sys

filename = 'inputs/2022/day12-test.txt'

def test_hill_init():
  hill = Hill('S', 0, 0)
  assert hill.height == ord('a')
  assert hill.start
  assert not hill.end
  assert hill.tentative_distance == 0
  hill = Hill('E', 4, 6)
  assert hill.height == ord('z')
  assert not hill.start
  assert hill.end
  assert hill.tentative_distance == sys.maxsize
  hill = Hill('g', 3, 3)
  assert hill.height == ord('g')
  assert not hill.start
  assert not hill.end
  assert hill.tentative_distance == sys.maxsize

def test_dijkstra_init():
  dijkstra = Dijkstra(filename)
  assert dijkstra.data
  assert len(dijkstra.unvisited) == 5 * 8

def test_dijkstra_find_path():
  dijkstra = Dijkstra(filename)
  assert dijkstra.find_path() == 31
