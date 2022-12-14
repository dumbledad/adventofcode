from day14 import Cave

filename = 'inputs/2022/day14-test.txt'

def test_cave_init():
  cave = Cave(filename)
  assert cave.data

def test_cave_bounds():
  cave = Cave(filename)
  assert cave.bounds == {
    'min_x': 494,
    'max_x': 503,
    'min_y': 0,
    'max_y': 9
  }